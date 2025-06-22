-----

## O que é um banco de dados SQLite e como ele funciona em Flutter?

Um **SQLite** é um sistema de gerenciamento de banco de dados relacional (SGBDR) único, pois ele é **incorporado** diretamente no seu aplicativo, sem a necessidade de um servidor separado. Pense nele como um banco de dados leve, sem servidor, que funciona lendo e gravando dados diretamente em arquivos comuns no disco do seu dispositivo.

Em Flutter, a ponte para o SQLite é feita principalmente através do pacote **`sqflite`**. Este plugin permite que seu app se comunique com as APIs nativas do SQLite presentes no Android, iOS (e outras plataformas), gerenciando a criação, abertura e fechamento desses arquivos de banco de dados. Todas as operações com `sqflite` são **assíncronas**, utilizando `Future`s, o que garante que a interface do usuário do seu app permaneça fluida e responsiva enquanto as operações de leitura e escrita acontecem em segundo plano. Você pode interagir com ele usando comandos **SQL puro** ou através de **ORMs** (Object-Relational Mappers) como o `drift` ou `floor`, que simplificam a manipulação de dados usando objetos Dart.

-----

## Quais são as vantagens de usar SQLite em aplicativos Flutter?

Usar SQLite em seus apps Flutter, especialmente com o `sqflite`, traz diversos benefícios:

* **Armazenamento Offline Robusto**: Seu app pode funcionar completamente offline, armazenando dados que podem ser sincronizados posteriormente com um servidor. Isso é vital para apps que precisam operar sem conexão constante.
* **Performance Local Otimizada**: Acesso e manipulação de dados diretamente no dispositivo são muito mais rápidos e eficientes do que depender de chamadas de rede para um servidor remoto, proporcionando uma experiência de usuário mais ágil.
* **Dados Estruturados e Relacionais**: Diferente de soluções simples como o `SharedPreferences`, o SQLite é um banco de dados relacional. Ele suporta tabelas, colunas, chaves primárias e estrangeiras, índices e consultas SQL complexas (`JOIN`s, `GROUP BY`, `ORDER BY`), permitindo uma organização de dados sofisticada.
* **Eficiência de Recursos**: O SQLite é incrivelmente leve, usando pouca memória e espaço em disco, o que o torna ideal para ambientes móveis.
* **Confiabilidade e Transações**: Ele suporta transações **ACID** (Atomicidade, Consistência, Isolamento, Durabilidade), garantindo que suas operações de banco de dados sejam confiáveis e que a integridade dos dados seja mantida, mesmo em caso de falhas.
* **Familiaridade com SQL**: Para desenvolvedores com experiência em bancos de dados relacionais, o SQL é uma linguagem familiar, facilitando a transição para o SQLite.

-----

## Quais são os tipos de dados básicos que posso armazenar em um banco de dados SQLite?

O SQLite possui um sistema de tipagem flexível, mas os tipos de dados básicos que você pode usar para definir colunas e armazenar valores são:

* **`NULL`**: Representa a ausência de valor.
* **`INTEGER`**: Para números inteiros (como `int` do Dart).
* **`REAL`**: Para números de ponto flutuante (como `double` do Dart).
* **`TEXT`**: Para strings de texto (como `String` do Dart).
* **`BLOB`**: Para dados binários brutos, como imagens ou arquivos (como `Uint8List` do Dart).

É importante notar que o SQLite não tem um tipo `BOOLEAN` nativo; o `sqflite` mapeia valores booleanos para **`INTEGER`** (0 para `false`, 1 para `true`). Para `DateTime`, você geralmente armazena como `INTEGER` (timestamp Unix) ou `TEXT` (string ISO 8601) e faz a conversão manualmente.

-----

## Como posso inserir novos registros em uma tabela SQLite usando Flutter?

Para inserir novos registros com `sqflite`, você usa o método `insert()` do seu objeto `Database`. Primeiro, prepare os dados como um `Map<String, dynamic>` onde as chaves são os nomes das colunas e os valores são os dados a serem inseridos.

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Exemplo de classe de modelo
class Produto {
  int? id;
  String nome;
  double preco;
  bool disponivel;

  Produto({this.id, required this.nome, required this.preco, this.disponivel = true});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'disponivel': disponivel ? 1 : 0, // Mapeia bool para int
    };
  }
}

// Helper para o banco de dados (exemplo simplificado)
class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'meu_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE produtos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            preco REAL NOT NULL,
            disponivel INTEGER DEFAULT 1
          )
        ''');
      },
    );
  }

  Future<int> **insertProduto**(Produto produto) async {
    final db = await database;
    return await db.**insert**(
      'produtos',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Estratégia de conflito
    );
  }
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  Produto novoProduto = Produto(nome: 'Notebook Gamer', preco: 4500.00);
  int id = await dbHelper.**insertProduto**(novoProduto);
  print('Produto inserido com ID: $id');
}
```

O método `insert()` retorna o **ID do último registro inserido** (se a coluna for `AUTOINCREMENT`).

-----

## Como posso inserir vários registros de uma vez em uma tabela SQLite?

Para inserir vários registros de forma eficiente e garantir a integridade, use uma **transação**. Isso agrupa todas as inserções como uma única operação atômica e melhora o desempenho significativamente, pois o banco de dados só precisa ser "commitado" uma vez ao final.

```dart
// No DatabaseHelper
Future<List<int>> **insertMultipleProdutos**(List<Produto> produtos) async {
  final db = await database;
  List<int> insertedIds = [];

  await db.**transaction**((txn) async { // Inicia a transação
    for (var produto in produtos) {
      int id = await txn.**insert**(
        'produtos',
        produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      insertedIds.add(id);
    }
  }); // A transação é commitada automaticamente ao final, ou revertida se houver erro
  print('${insertedIds.length} produtos inseridos em massa.');
  return insertedIds;
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  List<Produto> novosProdutos = [
    Produto(nome: 'Teclado Mecânico', preco: 300.00),
    Produto(nome: 'Mouse RGB', preco: 150.00),
  ];
  List<int> ids = await dbHelper.**insertMultipleProdutos**(novosProdutos);
  print('IDs dos produtos inseridos: $ids');
}
```

-----

## Como posso obter o ID do último registro inserido em uma tabela SQLite?

Ao usar `db.insert()` em `sqflite`, o valor de retorno do método **já é o ID do último registro inserido** (assumindo que a coluna de chave primária é `AUTOINCREMENT`).

```dart
// No DatabaseHelper (Exemplo já dado no "Como inserir...")
Future<int> **insertProduto**(Produto produto) async {
  final db = await database;
  int id = await db.insert( // 'id' aqui é o ID do registro recém-inserido
    'produtos',
    produto.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return id;
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  Produto meuProduto = Produto(nome: 'Webcam 4K', preco: 600.00);
  int **novoIdProduto** = await dbHelper.**insertProduto**(meuProduto);
  print('O ID do novo produto é: $novoIdProduto');
  meuProduto.id = novoIdProduto; // Você pode atribuir o ID de volta ao seu objeto Dart
}
```

-----

## Como posso filtrar os resultados de uma consulta usando a cláusula `WHERE`?

Para filtrar dados (`SELECT`) e obter apenas registros que correspondem a certas condições, você usa os parâmetros **`where`** e **`whereArgs`** no método `db.query()`.

* **`where`**: Uma string SQL que define a condição de filtro (ex: `'nome = ? AND preco > ?'`).
* **`whereArgs`**: Uma `List<Object?>` que contém os valores para substituir os `?` na sua string `where`. **Sempre use `whereArgs`** para prevenir ataques de injeção de SQL e garantir o tratamento correto dos valores.

<!-- end list -->

```dart
// No DatabaseHelper
Future<List<Produto>> **getProdutosDisponiveis**() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.**query**(
    'produtos',
    where: '**disponivel = ?**', // A ? será substituída
    whereArgs: [**1**],           // 1 para true em SQLite
  );
  return List.generate(maps.length, (i) => Produto.fromMap(maps[i]));
}

Future<List<Produto>> **getProdutosPorPrecoAcimaDe**(double precoMin) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.**query**(
    'produtos',
    where: '**preco > ?**',
    whereArgs: [**precoMin**],
  );
  return List.generate(maps.length, (i) => Produto.fromMap(maps[i]));
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  List<Produto> produtosDisponiveis = await dbHelper.**getProdutosDisponiveis**();
  print('Disponíveis: ${produtosDisponiveis.map((p) => p.nome).join(', ')}');
  List<Produto> produtosCaros = await dbHelper.**getProdutosPorPrecoAcimaDe**(500.00);
  print('Acima de R\$500: ${produtosCaros.map((p) => p.nome).join(', ')}');
}
```

-----

## Como posso agrupar os resultados de uma consulta usando a cláusula `GROUP BY`?

A cláusula `GROUP BY` é usada para agrupar linhas que têm os mesmos valores em colunas específicas em um único resumo. É frequentemente combinada com funções agregadas como `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`. No `sqflite`, você usa o parâmetro **`groupBy`** no método `db.query()`.

```dart
// No DatabaseHelper
Future<List<Map<String, dynamic>>> **getContagemDeProdutosPorDisponibilidade**() async {
  final db = await database;
  final List<Map<String, dynamic>> result = await db.**query**(
    'produtos',
    columns: ['disponivel', 'COUNT(*) AS total_produtos'], // Seleciona a coluna de agrupamento e a função agregada
    **groupBy**: 'disponivel', // Agrupa por 'disponivel'
    orderBy: 'disponivel ASC',
  );
  return result;
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  // Inserir alguns produtos para o exemplo
  await dbHelper.insertProduto(Produto(nome: 'Monitor', preco: 1000, disponivel: true));
  await dbHelper.insertProduto(Produto(nome: 'Câmera', preco: 2000, disponivel: false));
  await dbHelper.insertProduto(Produto(nome: 'Fone', preco: 500, disponivel: true));

  List<Map<String, dynamic>> contagem = await dbHelper.**getContagemDeProdutosPorDisponibilidade**();
  print('Contagem de produtos por disponibilidade:');
  for (var row in contagem) {
    String status = row['disponivel'] == 1 ? 'Disponível' : 'Indisponível';
    print('  $status: ${row['total_produtos']} produtos');
  }
}
```

-----

## Como posso excluir registros de uma tabela SQLite usando Flutter?

Para excluir registros, use o método `delete()` do `db` e, **crucialmente**, forneça uma cláusula **`WHERE`** (com `where` e `whereArgs`) para especificar quais registros serão removidos. **CUIDADO**: Se você não fornecer uma cláusula `WHERE`, **todos os registros na tabela serão excluídos\!**

```dart
// No DatabaseHelper
Future<int> **deleteProdutoPorId**(int id) async {
  final db = await database;
  return await db.**delete**(
    'produtos',
    where: '**id = ?**',
    whereArgs: [**id**],
  );
}

Future<int> **deleteProdutosIndisponiveis**() async {
  final db = await database;
  return await db.**delete**(
    'produtos',
    where: '**disponivel = ?**',
    whereArgs: [**0**],
  );
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  int idProdutoParaExcluir = await dbHelper.insertProduto(Produto(nome: 'Tablet Antigo', preco: 200.00, disponivel: false));
  int count = await dbHelper.**deleteProdutoPorId**(idProdutoParaExcluir);
  print('Registros excluídos por ID: $count');

  await dbHelper.insertProduto(Produto(nome: 'Fone de ouvido', preco: 100, disponivel: false));
  await dbHelper.insertProduto(Produto(nome: 'Capa de celular', preco: 50, disponivel: false));
  count = await dbHelper.**deleteProdutosIndisponiveis**();
  print('Registros indisponíveis excluídos: $count');
}
```

-----

## Quais os cuidados necessários ao usar `UPDATE`, `INSERT` e `DELETE`?

Operações de modificação de dados são poderosas e exigem atenção:

* **Validação de Dados**: Sempre valide os dados em seu app antes de enviar para o banco.
* **SQL Injection**: **Nunca concatene valores diretamente em strings SQL**. Sempre use parâmetros (`?`) e o array `whereArgs` (para `UPDATE` e `DELETE`) ou um `Map` de valores (para `INSERT`). O `sqflite` lida com isso de forma segura.
* **Cláusula `WHERE` (MUITO CRÍTICO para `UPDATE` e `DELETE`)**: **Sempre, sempre, sempre** inclua uma cláusula `WHERE` para especificar quais registros devem ser afetados. Omitir o `WHERE` resultará na modificação/exclusão de **todos os registros** da tabela, o que é quase sempre um erro grave.
* **Tratamento de Conflitos (`INSERT`)**: Use `conflictAlgorithm` no `insert()` para definir como lidar com violações de restrição (ex: chaves primárias duplicadas).
* **Transações**: Para sequências de operações que devem ser tratadas como uma única unidade lógica (todas ou nenhuma), use transações para garantir **atomicidade e integridade dos dados**.
* **Integridade Referencial (`DELETE`, `UPDATE`)**: Se você tem tabelas relacionadas (com chaves estrangeiras), entenda o comportamento de `ON DELETE` e `ON UPDATE` (ex: `CASCADE`, `RESTRICT`, `SET NULL`) ou gerencie a exclusão/atualização de registros filhos manualmente.
* **Confirmação do Usuário**: Para ações destrutivas (como `DELETE`), sempre peça uma confirmação ao usuário.
* **Tratamento de Erros**: Envolva todas as operações de banco de dados em blocos `try-catch` para lidar com possíveis exceções (problemas de I/O, violações de restrição, etc.).

-----

## Como posso criar tabelas relacionadas em um banco de dados SQLite?

Você cria tabelas relacionadas usando **chaves primárias (`PRIMARY KEY`)** e **chaves estrangeiras (`FOREIGN KEY`)**. A chave primária identifica unicamente um registro na tabela "pai", e a chave estrangeira na tabela "filha" referencia essa chave primária.

Exemplo de um relacionamento um-para-muitos (uma `Categoria` tem muitos `Produto`s):

```sql
CREATE TABLE **categorias** (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL UNIQUE
);

CREATE TABLE **produtos** (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  preco REAL NOT NULL,
  **categoria_id INTEGER NOT NULL**, -- Esta é a chave estrangeira
  **FOREIGN KEY (categoria_id) REFERENCES categorias(id)**
    ON DELETE CASCADE -- Opcional: define o que acontece ao deletar a categoria pai
    ON UPDATE CASCADE -- Opcional: define o que acontece ao atualizar o ID da categoria pai
);
```

No Flutter, você executa esses comandos SQL dentro do método `onCreate` do seu `DatabaseHelper` ou em uma função de migração.

-----

## Como posso consultar dados de tabelas relacionadas usando `JOIN`?

Para combinar colunas de tabelas relacionadas em uma única consulta, você usa a cláusula **`JOIN`**. O `INNER JOIN` é o tipo mais comum, retornando apenas as linhas onde há correspondência em ambas as tabelas. Para `JOIN`s, geralmente você precisará usar `db.rawQuery()` para escrever SQL puro.

```dart
// Exemplo de Modelos com relacionamento (simplificado)
class Categoria { int? id; String nome; Categoria({this.id, required this.nome}); }
class ProdutoComCategoria {
  int? id; String nomeProduto; double preco; String nomeCategoria;
  ProdutoComCategoria({this.id, required this.nomeProduto, required this.preco, required this.nomeCategoria});
}

// No DatabaseHelper
Future<List<ProdutoComCategoria>> **getProdutosComCategorias**() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.**rawQuery**('''
    SELECT
      P.id, P.nome AS nomeProduto, P.preco,
      C.nome AS nomeCategoria
    FROM produtos AS P
    **INNER JOIN categorias AS C ON P.categoria_id = C.id**
  ''');

  return List.generate(maps.length, (i) {
    return ProdutoComCategoria(
      id: maps[i]['id'],
      nomeProduto: maps[i]['nomeProduto'],
      preco: maps[i]['preco'],
      nomeCategoria: maps[i]['nomeCategoria'],
    );
  });
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  // (Certifique-se de ter inserido categorias e produtos com categoria_id válidos)
  List<ProdutoComCategoria> produtos = await dbHelper.**getProdutosComCategorias**();
  print('Produtos e suas categorias:');
  for (var p in produtos) {
    print('  ${p.nomeProduto} (R\$${p.preco}) - Categoria: ${p.nomeCategoria}');
  }
}
```

Use apelidos (`AS P`, `AS C`) para as tabelas e para as colunas que podem ter nomes duplicados (`C.nome AS nomeCategoria`) para evitar ambiguidades no resultado.

-----

## O que são transações em um banco de dados SQLite e por que são importantes?

Transações são sequências de uma ou mais operações de banco de dados que são tratadas como uma **única unidade lógica de trabalho**. Elas seguem as propriedades **ACID**:

* **Atomicidade**: Ou todas as operações são concluídas com sucesso, ou nenhuma delas é. Não há estado parcial.
* **Consistência**: A transação leva o banco de dados de um estado válido para outro estado válido, mantendo todas as regras de integridade.
* **Isolamento**: Transações em andamento são isoladas. As modificações de uma não são visíveis para outras até que a primeira seja finalizada.
* **Durabilidade**: Uma vez que uma transação é "commitada", suas alterações são permanentes e sobrevivem a falhas do sistema.

**Importância**: Transações são cruciais para a **integridade dos dados**. Elas garantem que seu banco de dados esteja sempre em um estado consistente, mesmo se algo der errado no meio de uma série de operações interdependentes. Além disso, melhoram o **desempenho** para operações em massa, pois as mudanças só são persistidas no disco uma vez.

-----

## Como posso reverter uma transação em caso de erro?

No `sqflite`, a reversão (rollback) de uma transação é **automática e implícita**. Se qualquer exceção for lançada dentro do bloco de código que você passa para `db.transaction()`, o `sqflite` detecta a exceção e automaticamente executa um `ROLLBACK`, desfazendo todas as operações da transação. Se o bloco for concluído sem erros, um `COMMIT` é feito implicitamente. Você não precisa chamar `ROLLBACK` explicitamente.

```dart
// No DatabaseHelper
Future<void> **operacaoTransacionalComErro**() async {
  final db = await database;
  try {
    await db.**transaction**((txn) async {
      await txn.insert('produtos', {'nome': 'Produto Temp 1', 'preco': 10.0, 'disponivel': 1});
      print('Produto Temp 1 inserido.');

      // Simula um erro
      throw Exception('Erro forçado para testar rollback!');

      await txn.insert('produtos', {'nome': 'Produto Temp 2', 'preco': 20.0, 'disponivel': 1});
      print('Produto Temp 2 inserido (não será se houver erro).');
    });
    print('Transação concluída com sucesso.');
  } catch (e) {
    print('Transação falhou e foi revertida: $e');
    // Aqui você pode lidar com o erro, talvez notificar o usuário.
  } finally {
    // Verifique o estado do banco de dados - nenhum produto temporário deve estar lá se houve erro.
    List<Map<String, dynamic>> produtos = await db.query('produtos');
    print('Produtos no DB após transação: $produtos');
  }
}

// Como usar:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  // Limpa a tabela para o teste
  await (await dbHelper.database).delete('produtos');
  await dbHelper.**operacaoTransacionalComErro**();
}
```

-----

## Quais são as vantagens de usar transações para garantir a integridade dos dados?

As transações são o pilar da integridade dos dados em bancos de dados por várias razões:

* **Evitam Inconsistências**: Ao tratar múltiplas operações como uma única unidade atômica, elas garantem que o banco de dados não termine em um estado parcialmente atualizado ou inconsistente se uma parte da operação falhar.
* **Confiabilidade**: Elas asseguram que os dados sigam as regras e restrições definidas (ex: chaves únicas, chaves estrangeiras, `NOT NULL`), revertendo as alterações se alguma regra for violada.
* **Recuperação de Falhas**: Em caso de travamento do aplicativo ou perda de energia, as transações garantem que os dados commitados estejam salvos e que as transações incompletas sejam automaticamente revertidas, prevenindo a corrupção do banco de dados.
* **Concorrência Segura**: Em ambientes onde múltiplas partes do seu app (ou até threads) podem tentar modificar os mesmos dados, o isolamento das transações impede que uma veja as mudanças incompletas da outra, evitando leituras "sujas" ou dados inconsistentes.

Em resumo, transações são essenciais para construir aplicativos robustos e confiáveis, onde a consistência e a validade dos dados são primordiais.