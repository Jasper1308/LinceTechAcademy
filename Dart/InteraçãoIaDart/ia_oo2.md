# Herança, Interfaces e Outros Recursos da POO em Dart

-----

## 1\. O que significa 'sobrescrever' um método em Dart e por que eu faria isso?

**Sobrescrever (Override)** um método em Dart significa **redefinir o comportamento** de um método que já existe em uma **classe pai (superclasse)**, dentro de uma **classe filha (subclasse)**. A subclasse fornece sua própria implementação para um método que ela herdou da superclasse.

**Por que fazer isso?**

Você sobrescreve um método para implementar o **Polimorfismo**, permitindo que objetos de diferentes classes (que compartilham uma superclasse) respondam ao mesmo chamado de método de maneiras distintas e apropriadas ao seu tipo. Isso é útil para:

* **Comportamentos Específicos**: Uma subclasse pode precisar de uma implementação diferente para um método herdado para atender às suas necessidades específicas.
    * Exemplo: Uma classe `Animal` pode ter um método `fazerBarulho()`, mas um `Cachorro` sobrescreveria para `latir()` e um `Gato` para `miar()`.
* **Adaptação de Lógica**: A lógica geral pode ser a mesma, mas com pequenas variações.
* **Extensão de Funcionalidade**: Adicionar mais funcionalidades ao comportamento original, mantendo a chamada ao método da classe pai.

Para sobrescrever um método, você usa a anotação **`@override`** (opcional, mas altamente recomendada) acima do método na subclasse. Isso ajuda o compilador a verificar se você está realmente sobrescrevendo um método existente e não criando um novo método com o mesmo nome por engano.

```dart
class Animal {
  void fazerBarulho() {
    print('Animal faz um barulho genérico.');
  }
}

class Cachorro extends Animal {
  @override // Anotação que indica sobrescrita
  void fazerBarulho() {
    print('Au au!'); // Comportamento específico do Cachorro
  }
}

class Gato extends Animal {
  @override
  void fazerBarulho() {
    print('Miau!'); // Comportamento específico do Gato
  }
}

void main() {
  Animal meuAnimal = Animal();
  Cachorro meuCachorro = Cachorro();
  Gato meuGato = Gato();

  meuAnimal.fazerBarulho(); // Saída: Animal faz um barulho genérico.
  meuCachorro.fazerBarulho(); // Saída: Au au!
  meuGato.fazerBarulho();     // Saída: Miau!
}
```

-----

## 2\. Como posso chamar o método original de uma classe pai em um método sobrescrito?

Você pode chamar o método original da classe pai dentro de um método sobrescrito usando a palavra-chave **`super`**.

`super` se refere à superclasse imediata do objeto atual. Ao chamar `super.nomeDoMetodo()`, você está invocando a implementação do método da classe pai. Isso é muito útil para:

* **Estender o Comportamento**: Adicionar lógica específica da subclasse *antes* ou *depois* da lógica da superclasse, sem reimplementar tudo.
* **Garantir a Execução da Lógica Base**: Assegurar que qualquer inicialização ou lógica essencial definida na classe pai seja sempre executada.

<!-- end list -->

```dart
class Veiculo {
  void ligar() {
    print('Veículo ligado.');
  }

  void acelerar() {
    print('Veículo acelerando.');
  }
}

class Carro extends Veiculo {
  @override
  void ligar() {
    super.ligar(); // Chama o método ligar() da classe Veiculo
    print('Carro pronto para partir.'); // Adiciona comportamento específico
  }

  @override
  void acelerar() {
    super.acelerar(); // Chama o método acelerar() da classe Veiculo
    print('Pneus girando mais rápido.'); // Adiciona comportamento específico
  }
}

void main() {
  Carro meuCarro = Carro();
  meuCarro.ligar();
  // Saída:
  // Veículo ligado.
  // Carro pronto para partir.

  meuCarro.acelerar();
  // Saída:
  // Veículo acelerando.
  // Pneus girando mais rápido.
}
```

-----

## 3\. Como posso criar um getter para acessar um atributo privado de uma classe?

Em Dart, um **getter** é um método especial que permite **ler (acessar)** o valor de um atributo de uma classe. Para acessar um atributo **privado** (aquele prefixado com `_`) de fora do arquivo onde a classe é definida, você **precisa** usar um getter público.

A sintaxe de um getter é: `tipo get nomeDoAtributo { return _atributoPrivado; }`

```dart
class Pessoa {
  String _nome;    // Atributo privado
  int _idade;      // Atributo privado

  Pessoa(this._nome, this._idade);

  // Getter público para acessar o _nome
  String get nome {
    return _nome;
  }

  // Getter público para acessar a _idade
  // Você pode omitir o corpo se for uma única expressão
  int get idade => _idade;

  // Um getter pode até mesmo retornar um valor calculado
  bool get ehMaiorDeIdade => _idade >= 18;
}

void main() {
  Pessoa pessoa = Pessoa('Ana', 25);

  // Acessando os atributos privados através dos getters públicos
  print('Nome: ${pessoa.nome}');          // Saída: Nome: Ana
  print('Idade: ${pessoa.idade}');        // Saída: Idade: 25
  print('É maior de idade? ${pessoa.ehMaiorDeIdade}'); // Saída: É maior de idade? true

  // print(pessoa._nome); // ERRO: Não pode acessar _nome diretamente de fora do arquivo
}
```

-----

## 4\. Em quais situações é melhor usar getters e setters em vez de acessar atributos diretamente?

Usar **getters** (para leitura) e **setters** (para escrita) em vez de acessar atributos diretamente (mesmo os públicos) é uma **melhor prática de encapsulamento** em Dart, e é preferível nas seguintes situações:

* **Validação de Dados (Setters)**: Quando você precisa garantir que um valor atribuído a um atributo atenda a certos critérios ou regras de negócio antes de ser definido.
  ```dart
  class Produto {
    double _preco;
    set preco(double novoPreco) {
      if (novoPreco > 0) {
        _preco = novoPreco;
      } else {
        print('Preço inválido! Deve ser maior que zero.');
      }
    }
    double get preco => _preco;
    Produto(this._preco);
  }
  // No main:
  // Produto p = Produto(100.0);
  // p.preco = -50.0; // Mensagem de erro, preco não muda
  ```
* **Lógica no Acesso (Getters)**: Quando o valor a ser retornado por um atributo precisa ser calculado ou formatado dinamicamente antes de ser acessado.
  ```dart
  class Aluno {
    String _nome;
    List<double> _notas;
    Aluno(this._nome, this._notas);

    double get mediaNotas { // Getter que calcula a média
      if (_notas.isEmpty) return 0.0;
      return _notas.reduce((a, b) => a + b) / _notas.length;
    }
    // No main:
    // Aluno a = Aluno('João', [7.0, 8.5, 9.0]);
    // print(a.mediaNotas); // Calcula e retorna 8.16...
  }
  ```
* **Refatoração Futura**: Se você precisar mudar a forma como um dado é armazenado internamente no futuro (ex: de um campo para um cálculo, ou vice-versa), usar getters/setters permite fazer a mudança sem alterar o código que usa essa propriedade.
* **Controle de Acesso**: Se você quer permitir a leitura de um atributo, mas não a escrita (apenas getter), ou vice-versa.
* **Debugging**: É mais fácil colocar *breakpoints* ou lógica de *logging* em getters e setters do que em acessos diretos.

Em Dart, você pode usar a sintaxe de propriedade (`obj.atributo`) mesmo para getters e setters, tornando o acesso através deles tão natural quanto o acesso direto, mas com os benefícios do encapsulamento.

-----

## 5\. O que é uma 'classe abstrata' e como ela difere de uma classe normal?

Uma **classe abstrata** é uma classe que não pode ser instanciada diretamente. Ela serve como um **modelo** ou **contrato** para outras classes, fornecendo uma base comum de atributos e métodos, mas sem a necessidade de implementar todos os seus métodos.

**Principais Diferenças de uma Classe Normal (Concreta)**:

| Característica        | Classe Normal (Concreta)                  | Classe Abstrata                         |
| :-------------------- | :---------------------------------------- | :-------------------------------------- |
| **Instanciação** | Pode ser instanciada (`new MyClass()`). | **Não pode ser instanciada** diretamente. |
| **Métodos Abstratos** | Todos os métodos devem ter implementação. | Pode ter **métodos abstratos** (sem corpo). |
| **Métodos Concretos** | Pode ter métodos com implementação.        | Pode ter métodos com implementação.     |
| **Uso** | Usada para criar objetos concretos.       | Usada como **superclasse base** para outras classes, impondo um contrato. |
| **Palavra-chave** | Nenhuma especial (apenas `class`).        | Usa a palavra-chave **`abstract class`**. |

**Métodos Abstratos**: São métodos declarados em uma classe abstrata que **não possuem corpo (implementação)**. Eles obrigam as subclasses concretas a fornecer sua própria implementação.

```dart
abstract class Figura { // Classe abstrata
  String cor;

  Figura(this.cor);

  void exibirCor() { // Método concreto (com implementação)
    print('Cor: $cor');
  }

  // Método abstrato: sem corpo. Subclasses concretas DEVEM implementá-lo.
  double calcularArea();
}

class Circulo extends Figura {
  double raio;
  Circulo(String cor, this.raio) : super(cor);

  @override
  double calcularArea() { // Implementação obrigatória
    return 3.14 * raio * raio;
  }
}

// class Quadrado extends Figura {} // ERRO: Precisa implementar calcularArea()

void main() {
  // Figura minhaFigura = Figura('verde'); // ERRO: Não pode instanciar classe abstrata

  Circulo c = Circulo('azul', 5.0);
  c.exibirCor();
  print('Área do círculo: ${c.calcularArea()}');
}
```

-----

## 6\. Quando devo usar classes abstratas em vez de classes concretas?

Use classes abstratas quando:

* **Define um Contrato Comum com Implementação Parcial**: Você quer que várias classes compartilhem uma base comum de atributos e alguns métodos já implementados, mas também quer forçar que cada subclasse forneça sua própria implementação para outros métodos (os abstratos).
    * Exemplo: `Figura` (abstrata) define `cor` e `exibirCor()`, mas deixa `calcularArea()` abstrato, pois a forma de calcular a área varia para `Circulo`, `Retangulo`, etc.
* **Criação de Hierarquias de Tipos**: Para estabelecer uma hierarquia de herança clara onde o tipo base é conceitual e não deve ser instanciado diretamente.
* **Polimorfismo para Comportamentos Compartilhados e Específicos**: Permite tratar objetos de diferentes subclasses como o tipo abstrato, mas ter a certeza de que eles implementam certos comportamentos específicos.
* **Evitar Objetos Incompletos**: Impede que desenvolvedores criem objetos de uma classe que não teria um sentido completo ou funcionalidade total por si só.

Não use classes abstratas quando:

* Você precisa instanciar diretamente a classe.
* A classe não tem métodos ou propriedades que precisam ser implementados pelas subclasses. Nesse caso, uma classe concreta ou até uma interface pode ser mais apropriada.

-----

## 7\. O que é 'herança' em Dart e como ela funciona?

**Herança** é um dos pilares da Programação Orientada a Objetos que permite que uma classe (chamada **subclasse**, classe filha ou classe derivada) adquira as características e comportamentos (atributos e métodos) de outra classe (chamada **superclasse**, classe pai ou classe base).

**Como funciona em Dart**:

* Dart usa a palavra-chave **`extends`** para indicar herança. Uma classe pode estender apenas **uma única** superclasse (herança de classe única).
* A subclasse herda todos os membros **públicos** e **protegidos** (em Dart, isso significa não-privados por `_`) da superclasse.
* A subclasse pode:
    * **Adicionar novos** atributos e métodos.
    * **Sobrescrever** (override) métodos da superclasse para fornecer sua própria implementação.
    * Chamar o construtor da superclasse usando `super()` no inicializador ou no corpo do construtor da subclasse.

<!-- end list -->

```dart
class Animal { // Superclasse
  String nome;

  Animal(this.nome);

  void comer() {
    print('$nome está comendo.');
  }

  void dormir() {
    print('$nome está dormindo.');
  }
}

class Cachorro extends Animal { // Subclasse que herda de Animal
  String raca;

  Cachorro(String nome, this.raca) : super(nome); // Chama o construtor da superclasse

  void latir() { // Método específico do Cachorro
    print('$nome (${raca}) está latindo: Au au!');
  }

  @override
  void comer() { // Sobrescrevendo o método comer() da superclasse
    super.comer(); // Chama a implementação original de Animal.comer()
    print('Cachorro gosta de ração.');
  }
}

void main() {
  Cachorro meuCachorro = Cachorro('Buddy', 'Golden Retriever');
  meuCachorro.comer();  // Usa o método sobrescrito, que chama o super.comer()
  meuCachorro.dormir(); // Usa o método herdado de Animal
  meuCachorro.latir();  // Usa o método específico de Cachorro
}
```

-----

## 8\. Qual a diferença entre herança e composição?

**Herança e Composição** são duas abordagens fundamentais para reutilizar código e construir relacionamentos entre classes, mas elas representam tipos diferentes de relacionamento:

* **Herança (Relação "É UM TIPO DE")**:

    * Representa uma relação "É UM TIPO DE". Ex: Um `Cachorro` **é um tipo de** `Animal`.
    * Uma classe adquire o comportamento da classe pai.
    * É forte, pois acopla a subclasse à superclasse, tornando difícil mudar a hierarquia posteriormente.
    * Promove a reutilização de código através da extensão de classes.
    * Pode levar a hierarquias de classes rígidas e profundas.
    * Exemplo: `class Carro extends Veiculo {}`

* **Composição (Relação "TEM UM")**:

    * Representa uma relação "TEM UM" ou "PARTE DE". Ex: Um `Carro` **tem um** `Motor`.

    * Uma classe inclui uma instância de outra classe como um de seus atributos.

    * A classe que "tem" delega a funcionalidade para o objeto contido.

    * É mais flexível do que a herança, pois você pode mudar o tipo do objeto contido em tempo de execução.

    * Favorece a reutilização de código através da delegação de responsabilidades.

    * É geralmente preferida à herança para flexibilidade e para evitar problemas de "explosão de hierarquia" (quando a hierarquia de herança se torna muito complexa).

    * Exemplo:

      ```dart
      class Motor {
        void ligar() => print('Motor ligado.');
      }

      class Carro {
        Motor motor; // Composição: Carro TEM UM Motor

        Carro(this.motor);

        void ligarCarro() {
          motor.ligar(); // Delega a funcionalidade para o Motor
          print('Carro funcionando.');
        }
      }

      void main() {
        Motor motorGasolina = Motor();
        Carro meuCarro = Carro(motorGasolina);
        meuCarro.ligarCarro();
      }
      ```

**Regra geral**: Prefira **composição** sobre herança (`prefer composition over inheritance`) sempre que possível, pois a composição geralmente leva a designs mais flexíveis e menos acoplados. Use herança quando realmente há uma relação "é um tipo de" e o polimorfismo é um requisito central.

-----

## 9\. O que é uma 'interface' em Dart e como ela define um contrato de comportamento?

Em Dart, uma **interface** é um contrato que define um conjunto de métodos (e getters/setters) que uma classe deve implementar. Em Dart, **todas as classes implicitamente definem uma interface**. Isso significa que você não usa uma palavra-chave explícita `interface` como em Java.

**Como define um contrato de comportamento**:

Quando uma classe **implementa** a interface de outra classe (usando a palavra-chave **`implements`**), ela se compromete a fornecer uma implementação para **todos** os métodos e atributos definidos na interface. É como assinar um contrato: "Se você diz que implementa esta interface, então você deve ter todas estas funcionalidades".

```dart
// Esta classe 'Motorista' define implicitamente uma interface
class Motorista {
  void dirigir() {
    print('Dirigindo um veículo.');
  }

  void parar() {
    print('Veículo parado.');
  }
}

// A classe 'Caminhao' implementa a interface de 'Motorista'
// Ela é obrigada a implementar todos os métodos de Motorista
class Caminhao implements Motorista {
  @override
  void dirigir() {
    print('Caminhão está sendo dirigido em estrada.');
  }

  @override
  void parar() {
    print('Caminhão parou com segurança.');
  }

  void carregarCarga() { // Método específico do Caminhão
    print('Carga sendo carregada no caminhão.');
  }
}

void main() {
  Caminhao meuCaminhao = Caminhao();
  meuCaminhao.dirigir(); // Chama o método implementado
  meuCaminhao.parar();   // Chama o método implementado
  meuCaminhao.carregarCarga();
}
```

-----

## 10\. Como uma classe pode implementar uma interface?

Uma classe pode implementar uma interface usando a palavra-chave **`implements`**, seguida pelo nome da classe que serve como interface.

```dart
// Definindo algumas interfaces implícitas
abstract class AcoesBasicas {
  void andar();
  void falar();
}

abstract class AcoesAvancadas {
  void pular();
  void correr();
}

// A classe 'Humano' implementa as interfaces 'AcoesBasicas' e 'AcoesAvancadas'
// Ela é obrigada a implementar TODOS os métodos de AMBAS as interfaces.
class Humano implements AcoesBasicas, AcoesAvancadas {
  String nome;

  Humano(this.nome);

  @override
  void andar() {
    print('$nome está andando.');
  }

  @override
  void falar() {
    print('$nome está falando.');
  }

  @override
  void pular() {
    print('$nome está pulando.');
  }

  @override
  void correr() {
    print('$nome está correndo.');
  }

  void estudar() { // Método específico do Humano
    print('$nome está estudando.');
  }
}

void main() {
  Humano pessoa = Humano('Alice');
  pessoa.andar();
  pessoa.falar();
  pessoa.pular();
  pessoa.correr();
  pessoa.estudar();

  // Polimorfismo com interfaces:
  AcoesBasicas alguemBasico = Humano('Bob');
  alguemBasico.andar(); // Só pode acessar métodos da interface AcoesBasicas
  // alguemBasico.correr(); // ERRO: correr não está na interface AcoesBasicas
}
```

-----

## 11\. Qual a diferença entre herança e implementação de interfaces?

| Característica        | Herança (`extends`)                                  | Implementação de Interfaces (`implements`)                 |
| :-------------------- | :--------------------------------------------------- | :--------------------------------------------------------- |
| **Relação** | "É UM TIPO DE" (subtipo real)                       | "TEM A CAPACIDADE DE" ou "AGE COMO" (contrato de comportamento) |
| **Reutilização** | Reutiliza **código** e **estrutura** da superclasse. | Reutiliza **contrato de comportamento** (assinaturas de métodos). |
| **Implementação** | Herda a implementação padrão. Pode sobrescrever.     | **Obrigatório implementar todos** os métodos da interface. |
| **Múltiplos** | Uma classe pode `extends` **apenas uma** classe.     | Uma classe pode `implements` **múltiplas** interfaces.   |
| **Acoplamento** | Mais acoplamento entre pai e filho.                  | Menos acoplamento; foco no contrato, não na implementação. |
| **Propósito** | Construir hierarquias de classes baseadas em especialização. | Definir um conjunto de comportamentos que classes diversas devem ter. |
| **Estado** | Herda os atributos (estado) da superclasse.          | Não herda atributos (estado); apenas o "que fazer".         |

**Em resumo**:

* **Herança** é para **reutilização de implementação** (reaproveitar o código existente) e quando há uma forte relação "é um tipo de".
* **Interfaces** são para **reutilização de contrato** (garantir que um conjunto de funcionalidades existe) e quando uma classe precisa demonstrar um conjunto de comportamentos, independentemente de sua hierarquia de herança.
  É comum usar ambas: uma classe pode herdar de uma superclasse e implementar uma ou mais interfaces.

-----

## 12\. Quais cenários devo usar métodos estáticos em vez de métodos de instância?

**Métodos estáticos** pertencem à **classe em si**, não a uma instância específica da classe. Eles são declarados com a palavra-chave `static`.

**Cenários para usar métodos estáticos**:

1.  **Funções Utilitárias/Auxiliares (Helper Functions)**: Quando um método realiza uma tarefa que não depende do estado de um objeto específico, mas sim de parâmetros de entrada ou de um contexto geral.

    ```dart
    class CalculadoraEstatica {
      static double pi = 3.14159; // Atributo estático

      static int somar(int a, int b) { // Método estático
        return a + b;
      }

      static double converterCelsiusParaFahrenheit(double celsius) {
        return (celsius * 9 / 5) + 32;
      }
    }
    // No main: CalculadoraEstatica.somar(5, 3);
    ```

2.  **Operações que não Requerem Acesso ao Estado do Objeto**: Se o método não precisa acessar nenhum atributo (não-estático) da instância da classe, ele pode ser estático.

    ```dart
    class ValidadorEmail {
      static bool isValid(String email) {
        return email.contains('@') && email.contains('.');
      }
    }
    // No main: ValidadorEmail.isValid('teste@exemplo.com');
    ```

3.  **Construtores `factory` que não precisam de uma instância**: Embora `factory`s possam ser usados para retornar instâncias existentes, um `factory` construtor pode ser considerado um "método estático" no sentido de que ele não opera em uma instância de `this`.

4.  **Constantes ou Dados Compartilhados pela Classe**: Embora não sejam métodos, atributos estáticos (`static const` ou `static final`) são a forma de ter dados que pertencem à classe e são compartilhados por todas as suas instâncias.

**Não use métodos estáticos quando**:

* O método precisa acessar ou modificar atributos de instância (não-estáticos) da classe.
* O método representa um comportamento que é intrínseco a um objeto específico.
* Você planeja sobrescrever o método em subclasses (métodos estáticos não podem ser sobrescritos).

-----

## 13\. Como posso acessar um método estático sem criar uma instância da classe?

Você acessa um método estático diretamente pelo **nome da classe**, seguido do operador de ponto (`.`), e depois o nome do método e seus parênteses. Você **não precisa (e não deve)** criar uma instância da classe para chamar um método estático.

```dart
class UtilitariosDeString {
  static String reverter(String texto) {
    return texto.split('').reversed.join();
  }

  static bool isPalindromo(String texto) {
    String textoLimpo = texto.toLowerCase().replaceAll(' ', '');
    return textoLimpo == reverter(textoLimpo); // Pode chamar outros métodos estáticos
  }
}

void main() {
  // Acessando métodos estáticos diretamente pelo nome da classe
  String textoOriginal = 'Hello Dart';
  String textoRevertido = UtilitariosDeString.reverter(textoOriginal);
  print('Texto revertido: $textoRevertido'); // Saída: Texto revertido: traD olleH

  String palavra = 'arara';
  print('$palavra é um palíndromo? ${UtilitariosDeString.isPalindromo(palavra)}'); // Saída: arara é um palíndromo? true
}
```

-----

## 14\. O que são 'enumeradores' em Dart e para que servem?

**Enumeradores (Enums)** em Dart são um tipo de dado especial que permite definir um conjunto fixo e finito de valores nomeados (constantes). Eles são usados para representar uma coleção de opções relacionadas de forma segura e legível.

**Para que servem**:

* **Definir um Conjunto Fixo de Opções**: Ideal para categorias ou estados que têm um número limitado de valores predefinidos.
    * Ex: Dias da semana, meses, status de um pedido, direções (Norte, Sul, Leste, Oeste).
* **Melhorar a Legibilidade do Código**: Em vez de usar números mágicos ou strings arbitrárias, os enums fornecem nomes autoexplicativos, tornando o código mais fácil de entender e manter.
* **Garantir a Segurança de Tipo**: O compilador pode verificar se você está usando um dos valores válidos do enumerador, prevenindo erros de digitação e valores inválidos em tempo de execução.
* **Facilitar o `switch` `case`**: Enums funcionam muito bem com declarações `switch`, permitindo que o compilador verifique se todos os casos possíveis foram tratados.

<!-- end list -->

```dart
// Exemplo de enumerador para os dias da semana
enum DiaDaSemana {
  segunda,
  terca,
  quarta,
  quinta,
  sexta,
  sabado,
  domingo,
}

// Exemplo de enumerador para o status de um pedido (Dart 2.17+ com membros)
enum StatusPedido {
  pendente(1),
  processando(2),
  enviado(3),
  entregue(4);

  final int codigo; // Membro do enum
  const StatusPedido(this.codigo); // Construtor para membros
}

void main() {
  DiaDaSemana hoje = DiaDaSemana.terca;

  if (hoje == DiaDaSemana.terca) {
    print('Hoje é terça-feira!');
  }

  switch (hoje) {
    case DiaDaSemana.segunda:
      print('Começo da semana.');
      break;
    case DiaDaSemana.sabado:
    case DiaDaSemana.domingo:
      print('Fim de semana!');
      break;
    default:
      print('Dia útil no meio da semana.');
  }

  StatusPedido meuStatus = StatusPedido.enviado;
  print('Status do pedido: ${meuStatus.name} (código: ${meuStatus.codigo})');
}
```

-----

## 15\. Em quais situações é melhor usar enumeradores em vez de constantes?

Embora você possa usar constantes (`const`) para simular um conjunto fixo de valores (ex: `const int STATUS_PENDENTE = 0;`), os enumeradores são geralmente a melhor escolha nas seguintes situações:

* **Segurança de Tipo**: Enums são tipos. Isso significa que uma variável declarada como `DiaDaSemana` só pode receber valores de `DiaDaSemana`, impedindo que você acidentalmente atribua um `int` ou `String` inválido. Constantes inteiras não fornecem essa segurança de tipo.

  ```dart
  // Com Enum (seguro):
  DiaDaSemana dia = DiaDaSemana.segunda;
  // dia = 1; // ERRO de tipo!

  // Com Constantes (menos seguro):
  const int SEGUNDA = 1;
  int diaNum = SEGUNDA;
  diaNum = 5; // Válido, mas 5 pode não significar um dia válido
  ```

* **Legibilidade e Auto-Completar (Autocompletion)**: Os nomes dos valores do enum são mais legíveis (ex: `StatusPedido.entregue` vs. `4`). O autocompletar do IDE também lista os valores do enum, facilitando a escolha correta e evitando erros.

* **Iteração e Obtenção de Todos os Valores**: Enums vêm com uma propriedade `values` que retorna uma lista de todos os valores do enumerador, o que é útil para iteração ou para criar *dropdowns*.

  ```dart
  for (var dia in DiaDaSemana.values) {
    print(dia);
  }
  ```

* **Membros e Comportamento (Dart 2.17+)**: Enums podem ter construtores, campos e métodos, permitindo que você associe dados e comportamento a cada valor do enum, o que é impossível com constantes simples. Isso é poderoso para adicionar metadados ou lógica específica a cada opção.

* **`switch` exhaustivo**: O compilador pode avisar se você não tratou todos os casos de um `switch` que usa um enumerador, ajudando a evitar bugs.

Use constantes quando você precisa de um valor fixo e imutável que não faz parte de um conjunto fechado de opções ou quando a segurança de tipo de um enum não é necessária. Para conjuntos de opções, enums são a escolha moderna e segura em Dart.