# Erros e Exceções em Dart: Tratamento e Boas Práticas

-----

## 1\. Qual a diferença entre um erro e uma exceção em Dart?

Em Dart, tanto erros quanto exceções indicam que algo inesperado aconteceu, mas eles representam **situações de gravidade e tratabilidade diferentes**:

* **Erro (`Error`)**:

    * Representa um **problema no programa que você geralmente não consegue (e não deveria tentar) recuperar** em tempo de execução.
    * Indica **falhas graves ou bugs** que apontam para um defeito lógico no código.
    * Exemplos comuns incluem `OutOfMemoryError` (memória insuficiente), `StackOverflowError` (estouro de pilha) ou `AbstractClassInstantiationError` (tentar criar instância de classe abstrata).
    * Erros geralmente levam ao encerramento do programa.

* **Exceção (`Exception`)**:

    * Representa uma **condição anormal, mas que é esperada e pode ser tratada ou recuperada** pelo programa.
    * Indica que algo fora do controle direto do seu código aconteceu, mas que você pode prever e lidar com isso.
    * Exemplos comuns incluem `FormatException` (dados com formato incorreto), `StateError` (estado inválido para uma operação) ou `RangeError` (índice fora dos limites).
    * Exceções são projetadas para serem capturadas e tratadas, permitindo que o programa continue sua execução.

Em resumo, pense em **Erros como falhas catastróficas** (bugs de programação) e **Exceções como eventos inesperados, mas que podem ser gerenciados** (condições excepcionais de runtime).

-----

## 2\. Em quais situações devo esperar encontrar um erro, e em quais devo esperar uma exceção?

* **Situações para esperar um `Error`**:

    * Quando há um **bug fundamental** ou uma falha de design no seu código que o programa não pode contornar.
    * Tentativas de usar APIs de forma incorreta ou violar restrições da linguagem.
    * Exemplos:
        * Tentar criar uma instância de uma **classe abstrata**.
        * Chamar um método `abstract` que não foi implementado.
        * **Esgotar a memória** disponível para o programa.
        * Uma **recursão infinita** que leva a um `StackOverflowError`.
        * Acessar uma variável **`late`** que não foi inicializada (pode lançar um `LateInitializationError`).

* **Situações para esperar uma `Exception`**:

    * Quando a entrada do usuário ou dados externos estão em um **formato incorreto**.
    * Tentar acessar um item em uma lista com um **índice inválido** (`RangeError`).
    * Tentar analisar uma string que **não pode ser convertida** para o tipo desejado (ex: `int.parse('abc')` lança `FormatException`).
    * Operações de rede ou disco que falham devido a **problemas externos** (ex: arquivo não encontrado, rede indisponível).
    * Tentar executar uma operação em um objeto que está em um **estado inválido** para aquela operação (`StateError`).
    * **Divisão por zero** (`IntegerDivisionByZeroException` para `~/`).

A regra geral é: se você pode prever a condição e potencialmente se recuperar dela, é uma exceção. Se é uma falha que indica um defeito no seu próprio código, é um erro.

-----

## 3\. O que fazem os blocos 'try', 'catch' e 'finally' em Dart?

Esses blocos são fundamentais para o **tratamento de exceções** em Dart:

* **`try`**:

    * Contém o código que você suspeita que **pode lançar uma exceção**.
    * Se uma exceção for lançada dentro do bloco `try`, a execução normal do bloco é interrompida e o controle é passado para o bloco `catch` correspondente. Se nenhuma exceção for lançada, o bloco `catch` é ignorado.

* **`catch`**:

    * É executado **se uma exceção for lançada** no bloco `try` associado.
    * Permite que você **capture** a exceção e execute um código para **lidar com ela**, como exibir uma mensagem de erro, registrar o problema ou tentar uma recuperação.
    * Pode ser acompanhado de `on` para capturar tipos específicos de exceções.
    * Pode ter dois parâmetros opcionais: o primeiro para a exceção em si, e o segundo para a *stack trace* (rastreamento de pilha), que mostra a sequência de chamadas de função até o ponto onde a exceção ocorreu.

* **`finally`**:

    * É um bloco **opcional** que sempre é executado, **independentemente** de uma exceção ter sido lançada ou não no bloco `try`.
    * É útil para **limpar recursos**, como fechar arquivos, conexões de banco de dados ou streams, garantindo que essas operações sejam realizadas mesmo se ocorrer um erro.
    * Se uma exceção foi lançada e capturada, o `finally` é executado depois do `catch`. Se uma exceção foi lançada mas **não foi capturada**, o `finally` é executado e a exceção é então propagada para cima na pilha de chamadas.

**Estrutura básica:**

```dart
try {
  // Código que pode lançar uma exceção
  int resultado = 10 ~/ 0; // Isso lança IntegerDivisionByZeroException
  print('Isso não será impresso');
} on IntegerDivisionByZeroException { // Captura um tipo específico
  print('Não é possível dividir por zero!');
} catch (e, s) { // Captura qualquer outra exceção (e = exceção, s = stack trace)
  print('Ocorreu uma exceção inesperada: $e');
  print('Stack trace: $s');
} finally {
  print('Este bloco sempre será executado, para limpeza ou finalização.');
}
print('O programa continua...');
```

-----

## 4\. Como posso capturar diferentes tipos de exceções usando 'catch'?

Você pode capturar diferentes tipos de exceções usando a cláusula **`on`** em conjunto com `catch`. Isso permite que você tenha lógica de tratamento específica para cada tipo de exceção.

1.  **Capturando um tipo específico (`on ExceptionType`)**:

    * Use `on NomeDaExcecao` para capturar apenas exceções daquele tipo (ou seus subtipos).
    * Se houver múltiplas cláusulas `on`, a primeira que corresponder ao tipo da exceção lançada será executada.

    <!-- end list -->

    ```dart
    try {
      // Exemplo que pode lançar FormatException ou RangeError
      String textoNumero = 'abc';
      // int valor = int.parse(textoNumero); // Lança FormatException

      List<int> lista = [1, 2, 3];
      print(lista[5]); // Lança RangeError
    } on FormatException catch (e) {
      print('Erro de formato nos dados: ${e.message}');
    } on RangeError catch (e) {
      print('Erro de índice fora dos limites: ${e.message}');
    } catch (e) { // Captura qualquer outra exceção não tratada acima
      print('Ocorreu um erro inesperado: $e');
    }
    ```

2.  **Capturando qualquer exceção (`catch (e)`)**:

    * Um `catch` sem `on` captura **qualquer tipo de exceção**.
    * É útil como um "catch-all" para garantir que nenhuma exceção não tratada passe.
    * Deve ser o **último `catch`** se houver cláusulas `on` específicas, pois a ordem de `on`s e `catch`s é importante (o mais específico primeiro).

3.  **Capturando com `Stack Trace` (`catch (e, s)`)**:

    * Se você precisar do rastreamento de pilha para depuração, adicione um segundo parâmetro ao `catch`.

    <!-- end list -->

    ```dart
    try {
      throw 'Algo deu errado!'; // Lança uma String como exceção
    } catch (e, s) {
      print('Exceção: $e');
      print('Stack Trace:\n$s');
    }
    ```

-----

## 5\. Em quais situações é útil usar o bloco 'finally'?

O bloco `finally` é útil em situações onde você precisa **garantir que um código seja executado** independentemente de uma exceção ter ocorrido ou não. Suas principais aplicações são para **limpeza de recursos** e **garantia de finalização**.

* **Fechamento de Recursos**:

    * Fechar arquivos abertos (`file.close()`).
    * Encerrar conexões de rede ou banco de dados (`connection.close()`).
    * Liberar recursos de memória ou hardware que foram alocados.
    * Garantir que um *stream* seja fechado.

  <!-- end list -->

  ```dart
  File? meuArquivo;
  try {
    meuArquivo = File('dados.txt');
    meuArquivo.writeAsStringSync('Alguns dados.');
    // Pode ocorrer uma exceção aqui, mas o arquivo será fechado.
    throw Exception('Erro ao escrever!');
  } catch (e) {
    print('Erro: $e');
  } finally {
    meuArquivo?.closeSync(); // Garante que o arquivo seja fechado
    print('Arquivo fechado, se aberto.');
  }
  ```

* **Garantia de Finalização de Operações**:

    * Redefinir um estado de UI (interface do usuário) após uma operação assíncrona, independentemente do sucesso ou falha.
    * Garantir que uma variável booleana de "carregando" seja definida como `false` após uma requisição de rede.
    * Executar código de logging ou auditoria.

  <!-- end list -->

  ```dart
  bool isLoading = true;
  try {
    // Simula uma operação de rede
    // throw Exception('Falha na rede!');
    print('Carregando dados...');
  } catch (e) {
    print('Erro ao carregar: $e');
  } finally {
    isLoading = false; // Garante que o indicador de carregamento seja desativado
    print('Carregamento finalizado. isLoading: $isLoading');
  }
  ```

O `finally` é crucial para manter a integridade do seu programa, prevenindo vazamentos de recursos e garantindo que o estado do sistema seja corretamente gerenciado.

-----

## 6\. Por que eu precisaria lançar uma exceção em meu código?

Lançar uma exceção (`throw`) é uma maneira de **sinalizar que ocorreu uma condição anormal ou um erro** em seu código que a função atual não pode (ou não deve) tratar diretamente. Você lança uma exceção para:

* **Indicar Falha na Pré-condição**: Se uma função recebe argumentos inválidos ou o estado do objeto não permite a operação.
  ```dart
  void sacar(double valor) {
    if (valor <= 0) {
      throw ArgumentError('O valor do saque deve ser positivo.');
    }
    // Lógica de saque...
  }
  ```
* **Informar Erros de Lógica/Negócio**: Se uma regra de negócio ou lógica interna é violada.
  ```dart
  enum StatusPedido { pendente, processando, enviado, entregue }
  void cancelarPedido(StatusPedido statusAtual) {
    if (statusAtual == StatusPedido.entregue) {
      throw StateError('Não é possível cancelar um pedido já entregue.');
    }
    // Lógica de cancelamento...
  }
  ```
* **Propagar Erros**: Se uma função de baixo nível detecta um problema que ela não pode resolver, mas que uma camada de nível superior pode.
  ```dart
  String lerConfiguracao(String path) {
    try {
      // Tenta ler um arquivo
      // Pode lançar um FileSystemException
    } catch (e) {
      throw Exception('Falha ao ler configuração em $path: $e'); // Relança uma exceção mais genérica ou com mais contexto
    }
    return 'config';
  }
  ```
* **Forçar Tratamento**: Exigir que o chamador da sua função lide com uma situação específica.
  ```dart
  // Se esta função não pode prosseguir sem um item válido
  dynamic getItem(List items, int index) {
    if (index < 0 || index >= items.length) {
      throw RangeError('Índice fora dos limites: $index');
    }
    return items[index];
  }
  ```

Ao lançar exceções, você separa o "o que fazer em caso de sucesso" do "o que fazer em caso de problema", tornando o código mais limpo e modular.

-----

## 7\. Como posso personalizar mensagens de erro ao lançar exceções?

Você pode personalizar mensagens de erro ao lançar exceções de duas maneiras principais:

1.  **Usando exceções predefinidas com mensagens customizadas**:
    Muitas das classes de exceção embutidas em Dart (`FormatException`, `ArgumentError`, `StateError`, etc.) têm construtores que aceitam uma string como mensagem.

    ```dart
    // FormatException
    String jsonString = '{invalid json';
    try {
      json.decode(jsonString);
    } on FormatException {
      throw FormatException('Os dados JSON fornecidos estão mal formatados.', jsonString);
    }

    // ArgumentError
    void processarIdade(int idade) {
      if (idade < 0 || idade > 120) {
        throw ArgumentError.value(idade, 'idade', 'Idade deve estar entre 0 e 120.');
      }
      print('Idade válida: $idade');
    }
    processarIdade(-5); // Lança ArgumentError com mensagem customizada

    // StateError
    bool estaConectado = false;
    void desconectar() {
      if (!estaConectado) {
        throw StateError('Não é possível desconectar, pois já estamos offline.');
      }
      estaConectado = false;
      print('Desconectado.');
    }
    desconectar(); // Lança StateError com mensagem customizada
    ```

2.  **Criando suas próprias classes de exceção customizadas**:
    Para um controle total e para representar cenários de erro específicos do seu domínio, você pode criar suas próprias classes de exceção. Recomenda-se que elas **estendam `Exception` ou `Error`**.

    ```dart
    class UsuarioNaoEncontradoException implements Exception {
      final String mensagem;
      UsuarioNaoEncontradoException(this.mensagem);

      @override
      String toString() => 'UsuarioNaoEncontradoException: $mensagem';
    }

    class ErroValidacaoDados extends Error { // Para erros mais graves de validação interna
      final String campo;
      final String valor;
      ErroValidacaoDados(this.campo, this.valor);

      @override
      String toString() => 'ErroValidacaoDados: Campo "$campo" com valor inválido "$valor".';
    }

    void buscarUsuario(String email) {
      if (email != 'admin@teste.com') {
        throw UsuarioNaoEncontradoException('Nenhum usuário encontrado com o email: $email');
      }
      print('Usuário admin encontrado!');
    }

    void validarConfig(Map config) {
      if (config['porta'] == null || config['porta'] < 1024) {
        throw ErroValidacaoDados('porta', config['porta'].toString());
      }
      print('Configuração de porta válida.');
    }

    try {
      buscarUsuario('inexistente@teste.com');
    } on UsuarioNaoEncontradoException catch (e) {
      print(e);
    }

    try {
      validarConfig({'porta': 80});
    } catch (e) {
      print(e);
    }
    ```

Usar mensagens claras e informativas (e classes de exceção customizadas quando apropriado) melhora muito a depuração e o tratamento de erros no seu aplicativo.

-----

## 8\. Quais são as melhores práticas para lançar exceções em Dart?

Seguir algumas melhores práticas ao lançar exceções melhora a robustez e a manutenibilidade do seu código:

* **Lance `Exception`s, não `Error`s (na maioria dos casos)**: `Error`s devem ser reservados para falhas de programação irrecuperáveis. Para condições recuperáveis, lance `Exception`s ou suas subclasses.
* **Lance exceções específicas**: Prefira lançar uma subclasse de `Exception` (como `FormatException`, `ArgumentError`, `StateError` ou suas próprias exceções customizadas) em vez de um `Exception` genérico ou uma `String`. Isso permite que o código que captura a exceção a trate de forma mais precisa.
* **Forneça mensagens claras e úteis**: A mensagem da exceção deve explicar *o que* deu errado e, se possível, *por que* deu errado, incluindo dados relevantes que ajudem na depuração.
    * Exemplo: `throw ArgumentError('Idade inválida: $idade. Deve ser entre 0 e 120.');`
* **Documente as exceções que uma função pode lançar**: Use a documentação (comentários `///`) para indicar quais exceções sua função pode lançar, para que os desenvolvedores que a utilizam saibam o que esperar e o que tratar.
  ```dart
  /// Valida uma senha.
  ///
  /// Lança um [FormatException] se a senha for muito curta.
  /// Lança um [ArgumentError] se a senha contiver caracteres inválidos.
  void validarSenha(String senha) { /* ... */ }
  ```
* **Evite lançar `null` ou tipos primitivos sem sentido**: Embora Dart permita `throw 'some string'`, é uma má prática. Sempre lance um objeto que seja uma subclasse de `Exception` ou `Error`.
* **Lance exceções no nível de abstração correto**: Não lance uma exceção de baixo nível (como um erro de banco de dados genérico) para o código de UI. Capture a exceção de baixo nível e relance uma exceção de nível superior que faça sentido para a camada que está chamando.
* **Não use exceções para controle de fluxo normal**: Exceções são para **eventos excepcionais**. Se uma condição é esperada e pode ser tratada com um `if/else`, não lance uma exceção.
    * **Anti-padrão**: Usar `try-catch` para verificar se um item existe em uma lista. Prefira `if (list.contains(item))` ou `if (list.indexOf(item) != -1)`.
* **Não "engula" exceções**: Se você capturar uma exceção e não fizer nada com ela, você está escondendo um problema. No mínimo, registre a exceção ou relance-a se não puder tratá-la adequadamente.

-----

## 9\. Qual a diferença entre usar 'assert' e lançar uma exceção para verificar condições?

`assert` e `throw` (lançar uma exceção) são usados para verificar condições e sinalizar problemas, mas têm propósitos e comportamentos muito diferentes:

* **`assert`**:

    * **Finalidade**: Usado para **verificar condições em tempo de desenvolvimento** que você acredita que **devem ser sempre verdadeiras**. Se a condição for falsa, um `AssertionError` é lançado.
    * **Comportamento**: As asserções são **ativadas apenas no modo de depuração** (`debug mode`) ou quando executadas com a flag `--enable-asserts`. Em **modo de produção (`release mode`) ou otimizado, as asserções são completamente ignoradas** e removidas pelo compilador, não gerando nenhum código ou custo em tempo de execução.
    * **Uso**: Ideal para validar pré-condições, pós-condições e invariantes que ajudam a pegar bugs cedo durante o desenvolvimento e testes. Não é para validar entrada do usuário ou condições recuperáveis.
    * **Sintaxe**: `assert(condicao, [mensagem])`;

  <!-- end list -->

  ```dart
  void setIdade(int idade) {
    assert(idade >= 0, 'A idade não pode ser negativa.'); // Só verifica em debug mode
    // Lógica para definir a idade
  }
  ```

* **Lançar uma Exceção (`throw`)**:

    * **Finalidade**: Usado para **sinalizar condições anormais ou erros que devem ser tratados** pelo programa em **qualquer ambiente (desenvolvimento ou produção)**.
    * **Comportamento**: Exceções são lançadas e precisam ser capturadas por um `try-catch`, ou o programa será encerrado. Elas estão sempre ativas e fazem parte da lógica de *runtime*.
    * **Uso**: Ideal para validar entrada do usuário, falhas de I/O, violações de regras de negócio ou qualquer condição que o programa precise lidar em produção.
    * **Sintaxe**: `throw Excecao();`

  <!-- end list -->

  ```dart
  void depositar(double valor) {
    if (valor <= 0) {
      throw ArgumentError('O valor do depósito deve ser positivo.'); // Ativa em qualquer modo
    }
    // Lógica de depósito
  }
  ```

**Resumo da diferença**: `assert` é uma ferramenta de **desenvolvimento/depuração** para pegar bugs, enquanto `throw` é para **lidar com condições de erro em tempo de execução** que o programa deve gerenciar, mesmo em produção.

-----

## 10\. Em quais situações o 'assert' é mais útil durante o desenvolvimento?

`assert` é extremamente útil durante o desenvolvimento e teste para:

1.  **Validar Pré-condições de Funções/Métodos**: Garantir que os argumentos passados para uma função são válidos antes de a função tentar usá-los.

    ```dart
    // Garante que o ID não seja nulo e seja positivo
    void buscarProduto(int? id) {
      assert(id != null && id > 0, 'ID do produto inválido.');
      // Lógica de busca...
    }
    ```

2.  **Validar Pós-condições**: Verificar que o estado do sistema ou o valor de retorno de uma função está correto após sua execução.

    ```dart
    int calcularSoma(int a, int b) {
      int soma = a + b;
      assert(soma == a + b, 'Erro interno na soma!'); // Verifica se o cálculo foi correto
      return soma;
    }
    ```

3.  **Verificar Invariantes de Classe**: Assegurar que as propriedades de um objeto mantêm um estado consistente em pontos críticos do código (ex: após o construtor ou após certas operações).

    ```dart
    class ContaBancaria {
      double _saldo;
      ContaBancaria(this._saldo) {
        assert(_saldo >= 0, 'Saldo inicial não pode ser negativo.');
      }
      void depositar(double valor) {
        _saldo += valor;
        assert(_saldo >= 0, 'Saldo negativo após depósito - BUG!');
      }
    }
    ```

4.  **Confirmar Comportamentos Esperados em Loops ou Condicionais**: Garantir que certos ramos de código, que você espera que não sejam alcançados ou que tenham um comportamento específico, funcionem como o previsto.

    ```dart
    enum Status { ativo, inativo, pendente }
    void processarStatus(Status s) {
      switch (s) {
        case Status.ativo:
          // ...
          break;
        case Status.inativo:
          // ...
          break;
        default:
          assert(false, 'Status inesperado: $s'); // Não deveria chegar aqui
      }
    }
    ```

5.  **Debugging Rápido**: Em vez de colocar `print`s temporários, um `assert` pode ser mais direto para verificar o valor de uma variável em um ponto específico, causando uma falha explícita se a condição não for atendida.

Em essência, `assert` é uma ferramenta para **"programação defensiva"** que ajuda a identificar problemas lógicos e bugs no código **durante o ciclo de desenvolvimento**, sem adicionar sobrecarga de desempenho ao código de produção final.