# Programação Orientada a Objetos (POO) em Dart: Fundamentos

-----

## 1\. Quais são os principais conceitos da orientação a objetos?

A Programação Orientada a Objetos (POO) é um paradigma de programação que se baseia no conceito de "objetos", que podem conter dados (atributos) e código (métodos). Os principais conceitos da POO são:

* **Abstração**: Focar nas características essenciais de algo e ocultar os detalhes complexos e irrelevantes. É como o controle remoto da TV: você usa os botões sem precisar saber como a mágica interna acontece.
* **Encapsulamento**: Agrupar dados (atributos) e os métodos que operam nesses dados em uma única unidade (a **classe**), protegendo os dados de acesso direto externo. Pense nisso como uma cápsula onde os dados são guardados e só podem ser acessados ou modificados através de "portas" controladas (os métodos).
* **Herança**: Permite que uma classe (subclasse ou classe filha) receba atributos e métodos de outra classe (superclasse ou classe pai). Isso promove a **reutilização de código** e estabelece uma relação "é um tipo de" (ex: um `Cachorro` é um tipo de `Animal`).
* **Polimorfismo**: Significa "muitas formas". Permite que objetos de diferentes classes sejam tratados como objetos de uma classe comum (sua superclasse ou interface). É como ter um botão "Ligar" que funciona de forma diferente em uma TV, um rádio ou um liquidificador – o comando é o mesmo, mas a ação muda dependendo do objeto.

-----

## 2\. Quais as vantagens de usar orientação a objetos em comparação com outras formas de programação?

A POO oferece diversas vantagens que a tornam um paradigma muito popular, especialmente para sistemas complexos:

* **Modularidade e Reutilização de Código**: Classes são como blocos de construção independentes. A herança e o encapsulamento facilitam a reutilização de código já testado, evitando a duplicação.
* **Manutenibilidade**: Graças ao encapsulamento e à modularidade, modificar ou corrigir uma parte do sistema geralmente tem um impacto limitado em outras partes, tornando a manutenção mais fácil.
* **Escalabilidade**: Sistemas construídos com POO são mais fáceis de expandir e adaptar a novas funcionalidades, pois você pode adicionar novas classes ou estender as existentes sem grandes refatorações.
* **Modelagem do Mundo Real**: A POO permite que você represente entidades do mundo real (como carros, clientes, pedidos) de forma mais intuitiva em seu código, com seus próprios dados e comportamentos.
* **Organização do Código**: Ajuda a estruturar o código de maneira lógica e hierárquica, o que é essencial para projetos grandes e para a colaboração entre desenvolvedores.
* **Flexibilidade (Polimorfismo)**: O polimorfismo permite escrever código mais genérico e flexível que pode operar em diferentes tipos de objetos, adaptando-se ao comportamento específico de cada um.

-----

## 3\. O que é uma 'classe' e como ela se relaciona com 'objetos'?

* Uma **`classe`** é um **molde, um projeto ou um blueprint** para criar objetos. Ela define a estrutura (quais **atributos** o objeto terá) e o comportamento (quais **métodos** o objeto poderá executar) que todos os objetos criados a partir dela seguirão. A classe é uma abstração; ela não ocupa espaço na memória do programa.
* Um **`objeto`** (ou instância) é uma **ocorrência concreta** de uma classe. É a materialização desse molde. Quando você cria um objeto a partir de uma classe, ele ganha existência na memória e passa a ter seus próprios valores para os atributos definidos na classe.

**Relação**: Pense na classe `Carro` como o design de um carro. Ela especifica que todo carro terá uma cor, um modelo e poderá acelerar ou frear. Um **objeto** `meuCarro` é um carro específico que você construiu a partir desse design (por exemplo, um "Fiat Uno vermelho 2020"). Você pode criar vários objetos (`seuCarro`, `outroCarro`) a partir da mesma classe `Carro`, e cada um terá suas próprias características únicas.

```dart
// Classe (o molde)
class Cachorro {
  String nome; // Atributo: cada cachorro terá um nome
  String raca; // Atributo: cada cachorro terá uma raça

  Cachorro(this.nome, this.raca); // Construtor: como criar um cachorro

  void latir() { // Método: o que um cachorro pode fazer
    print('$nome está latindo!');
  }
}

void main() {
  // Objeto (uma instância real da classe Cachorro)
  Cachorro rex = Cachorro('Rex', 'Pastor Alemão');
  rex.latir(); // Acessando o método do objeto Rex

  // Outro objeto, da mesma classe, mas com seus próprios dados
  Cachorro bob = Cachorro('Bob', 'Poodle');
  bob.latir(); // Acessando o método do objeto Bob
}
```

-----

## 4\. O que são 'métodos' e como eles funcionam dentro de uma classe?

* **`Métodos`** são **funções que pertencem a uma classe** e que definem o **comportamento** que os objetos dessa classe podem executar. Eles operam nos dados (atributos) do objeto ao qual pertencem ou realizam alguma ação relacionada a esse objeto.
* **Funcionamento**:
    * Um método é declarado **dentro do corpo da classe**.
    * Ele tem acesso direto aos **atributos do próprio objeto** (`this` é implicitamente acessível).
    * Pode aceitar parâmetros e retornar valores, exatamente como funções normais.
    * Para que um método seja executado, você precisa de uma **instância** (um objeto) da classe.

<!-- end list -->

```dart
class ContaBancaria {
  double _saldo; // Atributo privado que o método vai manipular

  ContaBancaria(this._saldo);

  // Método para depositar dinheiro
  void depositar(double valor) {
    if (valor > 0) {
      _saldo += valor; // Modifica o atributo _saldo do objeto
      print('Depósito de \$${valor.toStringAsFixed(2)} realizado. Novo saldo: \$${_saldo.toStringAsFixed(2)}');
    } else {
      print('Valor de depósito inválido.');
    }
  }

  // Método para obter o saldo (um getter explícito)
  double getSaldo() {
    return _saldo; // Retorna o valor do atributo _saldo
  }
}

void main() {
  ContaBancaria minhaConta = ContaBancaria(100.0);
  minhaConta.depositar(50.0); // Chamando o método 'depositar' do objeto 'minhaConta'
  print('Saldo atual: \$${minhaConta.getSaldo().toStringAsFixed(2)}'); // Chamando o método 'getSaldo'
}
```

-----

## 5\. Como posso acessar os métodos de um objeto em Dart?

Para acessar e chamar os métodos de um objeto em Dart, você usa o **operador de ponto (`.`)** logo após o nome da variável que referencia o objeto. Em seguida, você escreve o nome do método e os parênteses (com quaisquer argumentos necessários, se houver).

```dart
class Calculadora {
  int somar(int a, int b) {
    return a + b;
  }

  double dividir(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Divisão por zero não é permitida.');
    }
    return a / b;
  }
}

void main() {
  Calculadora calc = Calculadora(); // Primeiro, crie um objeto (uma instância) da classe

  // Agora, acesse e chame os métodos do objeto 'calc'
  int resultadoSoma = calc.somar(10, 5);
  print('Soma: $resultadoSoma'); // Saída: Soma: 15

  double resultadoDivisao = calc.dividir(20.0, 4.0);
  print('Divisão: $resultadoDivisao'); // Saída: Divisão: 5.0

  try {
    calc.dividir(10.0, 0.0); // Tentando uma divisão por zero para testar a exceção
  } catch (e) {
    print(e); // Saída: Invalid argument(s): Divisão por zero não é permitida.
  }
}
```

-----

## 6\. Qual a diferença entre atributos 'públicos' e 'privados'?

Em Dart, a visibilidade (ou encapsulamento) de atributos e métodos é controlada de uma forma única e simples, baseada no **nível do arquivo (biblioteca)**:

* **Atributos Públicos**:

    * São atributos (e métodos) que podem ser **acessados de qualquer lugar** no código, tanto dentro quanto fora do arquivo (`.dart`) onde a classe é definida.
    * Em Dart, um atributo (ou método) é público **por padrão**, ou seja, se você não colocar nenhum prefixo especial.

  <!-- end list -->

  ```dart
  class Pessoa {
    String nome; // Público por padrão
    int idade;   // Público por padrão

    Pessoa(this.nome, this.idade);
  }

  void main() {
    Pessoa p = Pessoa('Carlos', 30);
    print(p.nome);  // Acesso direto ao atributo público 'nome'
    print(p.idade); // Acesso direto ao atributo público 'idade'
  }
  ```

* **Atributos Privados (Visibilidade de Biblioteca/Arquivo)**:

    * São atributos (e métodos) que podem ser acessados **apenas dentro do mesmo arquivo (`.dart`)** onde foram declarados. Eles não podem ser acessados de outros arquivos, mesmo que esses arquivos importem a classe.
    * Para tornar um atributo (ou método) privado em Dart, você o prefixa com um **underline (`_`)**.
    * Isso é uma forma de encapsulamento no nível do arquivo, diferente de `private` em linguagens como Java ou C\#, que seria no nível da classe.

  <!-- end list -->

  ```dart
  // --- Arquivo: 'minha_classe.dart' ---
  class MinhaClasse {
    String _atributoSecreto; // Privado para este arquivo
    String atributoAberto;  // Público

    MinhaClasse(this._atributoSecreto, this.atributoAberto);

    void _metodoInterno() { // Método privado para este arquivo
      print('Método privado interno executado.');
    }

    void metodoPublico() {
      _metodoInterno(); // Pode chamar o método privado dentro do mesmo arquivo
      print('Atributo secreto: $_atributoSecreto'); // Pode acessar o atributo privado
    }
  }

  // --- Arquivo: 'main.dart' (que importa 'minha_classe.dart') ---
  import 'minha_classe.dart';

  void main() {
    MinhaClasse obj = MinhaClasse('informação confidencial', 'informação pública');
    print(obj.atributoAberto); // OK: Acesso ao atributo público
    obj.metodoPublico();        // OK: Chama o método público

    // print(obj._atributoSecreto); // ERRO: Não pode acessar de fora do arquivo
    // obj._metodoInterno();       // ERRO: Não pode acessar de fora do arquivo
  }
  ```

O uso de atributos privados (`_`) é uma prática fundamental para o **encapsulamento**, pois impede o acesso direto e não controlado aos dados internos de um objeto. Isso incentiva o uso de métodos (como getters e setters) para interagir com esses dados, o que ajuda a manter a integridade e a consistência do estado do objeto.

-----

## 7\. Qual a diferença entre um construtor padrão e um construtor nomeado?

Dart oferece flexibilidade na criação de objetos através de diferentes tipos de construtores:

* **Construtor Padrão (Unnamed Constructor)**:

    * É o construtor "principal" de uma classe. Uma classe pode ter **apenas um construtor padrão**.
    * Ele não tem um nome explícito, apenas o nome da classe.
    * É o construtor que é chamado quando você cria um objeto usando a sintaxe `NomeDaClasse()`.
    * Se você não definir nenhum construtor para sua classe, Dart fornece um construtor padrão implícito (sem argumentos) automaticamente.

  <!-- end list -->

  ```dart
  class Produto {
    String nome;
    double preco;

    // Construtor Padrão
    Produto(this.nome, this.preco) {
      print('Produto "$nome" criado com o construtor padrão.');
    }
  }

  void main() {
    Produto p1 = Produto('Smartphone', 2500.0); // Chama o construtor padrão
    print('${p1.nome} - \$${p1.preco}');
  }
  ```

* **Construtor Nomeado (Named Constructor)**:

    * Permite que uma classe tenha **múltiplos construtores**, cada um com um nome único e descritivo.
    * São úteis quando você precisa de **diferentes maneiras de criar um objeto** da mesma classe, com diferentes conjuntos de parâmetros ou lógicas de inicialização.
    * A sintaxe é `NomeDaClasse.nomeDoConstrutor(parametros)`.

  <!-- end list -->

  ```dart
  class Ponto {
    double x;
    double y;

    Ponto(this.x, this.y); // Construtor padrão

    // Construtor nomeado para criar um ponto na origem (0,0)
    Ponto.origem() : x = 0.0, y = 0.0 {
      print('Ponto na origem criado.');
    }

    // Construtor nomeado para criar um ponto a partir de uma string "x,y"
    Ponto.fromString(String coords) {
      final partes = coords.split(',');
      x = double.parse(partes[0]);
      y = double.parse(partes[1]);
      print('Ponto criado de string: $coords');
    }

    @override
    String toString() => '($x, $y)';
  }

  void main() {
    Ponto p1 = Ponto(10.0, 20.0);           // Chama o construtor padrão
    Ponto p2 = Ponto.origem();              // Chama o construtor nomeado 'origem'
    Ponto p3 = Ponto.fromString('5,7');     // Chama o construtor nomeado 'fromString'

    print('P1: $p1'); // Saída: P1: (10.0, 20.0)
    print('P2: $p2'); // Saída: P2: (0.0, 0.0)
    print('P3: $p3'); // Saída: P3: (5.0, 7.0)
  }
  ```

Construtores nomeados são uma ferramenta poderosa para criar APIs mais expressivas e seguras para a inicialização de objetos, oferecendo clareza sobre a intenção da criação do objeto.

-----

## 8\. O que são 'factories' em Dart e quando devo usá-las?

`factories` (construtores de fábrica) em Dart são construtores especiais, prefixados com a palavra-chave **`factory`**. Eles não necessariamente criam uma nova instância da classe toda vez que são chamados.

**O que fazem**:

* Um construtor `factory` pode **retornar uma instância existente** de uma classe (de um cache, por exemplo), ou **retornar uma instância de uma subclasse**, ou mesmo **criar uma nova instância** de forma condicional.
* Ao contrário dos construtores normais, um `factory` não tem acesso direto a `this` (o objeto em construção) durante sua execução, pois a instância ainda não foi criada por ele. Eles são mais como métodos estáticos que têm a responsabilidade de produzir uma instância da classe.
* Eles são usados quando a lógica de criação do objeto é mais complexa do que uma simples inicialização de campos.

**Sintaxe**: `factory NomeDaClasse.nomeDoConstrutor(parametros) { ... return instanciaDaClasse; }`

**Quando devo usá-las**:

1.  **Cachear Instâncias (Padrão Singleton ou Pool de Objetos)**: Quando você quer garantir que apenas uma instância de uma classe exista (Singleton) ou que instâncias sejam reutilizadas de um pool em vez de criar novas a cada vez.

    ```dart
    class Logger {
      static final Map<String, Logger> _cache = {}; // Cache de instâncias

      // Construtor factory que gerencia o cache
      factory Logger(String name) {
        if (_cache.containsKey(name)) {
          return _cache[name]!; // Retorna instância existente
        }
        final logger = Logger._internal(name); // Cria uma nova instância
        _cache[name] = logger;
        return logger;
      }

      // Construtor privado real que faz a inicialização
      Logger._internal(this.name);

      final String name;

      void log(String message) {
        print('[$name] $message');
      }
    }

    void main() {
      var logger1 = Logger('APP_LOG');
      logger1.log('Mensagem 1');

      var logger2 = Logger('APP_LOG'); // Retorna a MESMA instância de logger1
      logger2.log('Mensagem 2');

      print(identical(logger1, logger2)); // Saída: true (são o mesmo objeto)
    }
    ```

2.  **Retornar Subclasses Condicionalmente**: Quando você tem uma superclasse (ou uma classe abstrata) e quer que o construtor retorne uma subclasse específica baseada em algum parâmetro.

    ```dart
    abstract class Shape {
      // Factory que decide qual subclasse retornar
      factory Shape(String type) {
        if (type == 'circle') {
          return Circle();
        } else if (type == 'square') {
          return Square();
        }
        throw ArgumentError('Tipo de forma desconhecido: $type');
      }
      void draw(); // Método abstrato
    }

    class Circle implements Shape { // Implementa a interface Shape
      @override
      void draw() => print('Desenhando Círculo');
    }

    class Square implements Shape { // Implementa a interface Shape
      @override
      void draw() => print('Desenhando Quadrado');
    }

    void main() {
      final circle = Shape('circle'); // Retorna uma instância de Circle
      circle.draw();

      final square = Shape('square'); // Retorna uma instância de Square
      square.draw();
    }
    ```

3.  **Deserialização (JSON para Objeto)**: Quando você precisa criar um objeto a partir de dados externos (como JSON) e pode haver lógica de validação, conversão ou análise complexa.

    ```dart
    import 'dart:convert';

    class User {
      final String name;
      final int age;

      User(this.name, this.age);

      // Factory para criar User a partir de um mapa JSON
      factory User.fromJson(Map<String, dynamic> json) {
        if (!json.containsKey('name') || !json.containsKey('age')) {
          throw FormatException('JSON inválido: faltam "name" ou "age".');
        }
        return User(json['name'] as String, json['age'] as int);
      }
    }

    void main() {
      final String userJson = '{"name": "Alice", "age": 30}';
      final Map<String, dynamic> userMap = json.decode(userJson);
      final user = User.fromJson(userMap);
      print('Usuário: ${user.name}, Idade: ${user.age}');

      try {
        User.fromJson({'nome': 'Bob'}); // JSON inválido
      } on FormatException catch (e) {
        print(e); // Saída: FormatException: JSON inválido: faltam "name" ou "age".
      }
    }
    ```

Em resumo, use `factory` quando a criação de uma instância da classe não é um simples ato de alocar memória e inicializar campos, mas envolve lógica condicional, reutilização de instâncias, ou a necessidade de retornar um tipo diferente da classe diretamente.