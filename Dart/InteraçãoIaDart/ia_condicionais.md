# Controle de Fluxo em Dart: Decisão, Repetição e Exceções

-----

## 1\. Diferença entre 'if', 'else if' e 'else'

`if`, `else if` e `else` são estruturas de **decisão** que controlam a execução de blocos de código baseados em condições.

* **`if`**: Executa um bloco de código **somente se** sua condição for verdadeira. É o ponto de partida de qualquer sequência condicional.
* **`else if`**: Testa uma **nova condição** se a condição do `if` (ou do `else if` anterior) for falsa. Você pode ter vários `else if`s, e o primeiro com condição verdadeira executa seu bloco e encerra a verificação.
* **`else`**: Executa um bloco de código **se todas as condições anteriores (`if` e `else if`) forem falsas**. É o "caminho padrão" e é opcional.

-----

## 2\. Cuidados com 'if' e 'else'

Para um código claro e robusto ao usar `if` e `else`, fique atento a:

* **Evitar Aninhamento Excessivo**: Muitos `if`s um dentro do outro (`if` aninhado) tornam o código ilegível. Use **cláusulas de guarda** (retornar cedo) ou combine condições com `&&` e `||`.
* **Cobertura Completa das Condições**: Certifique-se de que todos os cenários possíveis sejam tratados. O `else` é útil para capturar casos não previstos.
* **Clareza nas Condições**: Mantenha as condições simples e legíveis. Quebre condições complexas em variáveis auxiliares.
* **Ordem das Condições (`else if`)**: A ordem importa. Coloque as condições **mais específicas primeiro** para evitar que uma condição mais genérica "capture" o caso indevidamente.
* **Evitar `else` Desnecessário**: Se o bloco `if` sempre termina com `return`, `throw` ou `break`, o `else` subsequente é redundante.

-----

## 3\. Importância da palavra-chave 'break' em um 'switch case'

A palavra-chave **`break`** é **crucial** em um `switch case` porque ela **interrompe a execução** do bloco `switch` após um `case` correspondente ter sido executado.

Sem o `break`, o fluxo de execução "cairia" para o próximo `case` (comportamento conhecido como "fall-through"), executando o código dele também, o que geralmente não é o comportamento desejado.

```dart
String clima = 'chuvoso';
switch (clima) {
  case 'ensolarado':
    print('Leve óculos de sol.');
    break; // Essencial para sair do switch
  case 'chuvoso':
    print('Leve guarda-chuva.'); // Este será executado
    break; // Essencial para sair do switch
  case 'nublado':
    print('Pode refrescar.');
    break;
  default:
    print('Verifique a previsão.');
}
```

-----

## 4\. Quando devo usar 'switch' em vez de uma série de 'if else'?

Use `switch` em vez de uma série de `if else` quando você tem **múltiplas condições que verificam a igualdade de uma única variável** com diferentes valores.

**Vantagens do `switch`:**

* **Legibilidade**: Torna o código mais limpo e fácil de ler quando há muitas opções para uma única variável.
* **Desempenho**: Em alguns casos, pode ser ligeiramente mais eficiente para um grande número de `case`s, pois o compilador pode otimizá-lo.
* **Consolidação de Casos**: Permite agrupar vários `case`s para executar o mesmo bloco de código (caindo de um `case` para o próximo **sem `break`** até o último).

**Exemplo:**

```dart
int diaDaSemana = 3; // 1 = Segunda, 2 = Terça, etc.

switch (diaDaSemana) {
  case 1:
    print('Dia útil.');
    break;
  case 2:
    print('Dia útil.');
    break;
  case 3:
    print('Dia útil.');
    break; // Mais claro que muitos else if para a mesma variável
  case 4:
    print('Dia útil.');
    break;
  case 5:
    print('Dia útil.');
    break;
  case 6:
    print('Fim de semana!');
    break;
  case 7:
    print('Fim de semana!');
    break;
  default:
    print('Número inválido para dia da semana.');
}
```

-----

## 5\. Diferença entre um loop 'for' tradicional e um loop 'for...in'

Ambos são usados para iteração, mas de formas diferentes:

* **`for` tradicional (Baseado em índice/condição)**:

    * Sintaxe: `for (inicialização; condição; incremento/decremento)`
    * Ideal para: Repetir um bloco de código um **número fixo de vezes**, iterar sobre coleções usando **índices numéricos**, ou quando você precisa de controle explícito sobre o contador.

  <!-- end list -->

  ```dart
  for (int i = 0; i < 5; i++) {
    print('Contagem: $i'); // Imprime de 0 a 4
  }

  List<String> frutas = ['maçã', 'banana', 'laranja'];
  for (int i = 0; i < frutas.length; i++) {
    print('Fruta no índice $i: ${frutas[i]}');
  }
  ```

* **`for...in` (Baseado em elementos/Iterável)**:

    * Sintaxe: `for (elemento in iteravel)`
    * Ideal para: Iterar diretamente sobre os **elementos de uma coleção** (como `List`, `Set`, `Map.keys`, `Map.values`), sem se preocupar com índices. Mais legível para esse fim.

  <!-- end list -->

  ```dart
  List<String> nomes = ['Alice', 'Bob', 'Charlie'];
  for (String nome in nomes) {
    print('Olá, $nome!');
  }

  Set<int> numeros = {10, 20, 30};
  for (int numero in numeros) {
    print('Número: $numero');
  }
  ```

-----

## 6\. Como posso repetir um bloco de código um número específico de vezes?

Para repetir um bloco de código um número específico de vezes, o loop **`for` tradicional** é a escolha mais comum e adequada.

```dart
// Repetir 10 vezes
for (int i = 0; i < 10; i++) {
  print('Esta é a repetição número ${i + 1}');
}

// Repetir 5 vezes, exibindo uma mensagem diferente
for (int contador = 1; contador <= 5; contador++) {
  print('Processando item $contador de 5...');
}
```

-----

## 7\. Quais são os riscos de usar um loop 'while' sem uma condição de parada adequada?

Usar um loop **`while` sem uma condição de parada adequada** (ou uma condição que nunca se torna falsa) resultará em um **loop infinito**. Os riscos incluem:

* **Travamento do Programa**: O programa ficará preso no loop, consumindo 100% da CPU e da memória disponível, e parecerá travado.
* **Consumo Excessivo de Recursos**: A CPU e a RAM serão sobrecarregadas, podendo causar lentidão no sistema operacional ou até mesmo travamento completo do computador.
* **Esgotamento da Bateria**: Em dispositivos móveis ou laptops, um loop infinito esgotará a bateria rapidamente.
* **Impossibilidade de Prosseguir**: Qualquer código após o loop infinito nunca será alcançado.
* **Difícil Depuração**: Pode ser complicado identificar a causa do travamento em programas maiores.

**Exemplo de loop infinito (CUIDADO\!):**

```dart
int contador = 0;
while (contador < 5) {
  print('Isso vai imprimir para sempre se não for incrementado!');
  // Faltou 'contador++;' aqui!
}
```

Para evitar isso, sempre garanta que a condição do `while` se tornará falsa em algum momento, seja por meio de um incremento/decremento, uma entrada do usuário, uma alteração de estado, etc.

-----

## 8\. Quando é adequado usar for e usar while?

A escolha entre `for` e `while` depende do cenário:

* **Usar `for` quando**:

    * Você sabe o **número exato de iterações** que precisa realizar.
    * Você precisa iterar sobre os **elementos de uma coleção** (usando `for...in`).
    * Você precisa de um **contador** ou índice para acessar elementos.

  Exemplos: Imprimir números de 1 a 10, percorrer uma lista de nomes, repetir uma tarefa N vezes.

* **Usar `while` quando**:

    * Você **não sabe o número exato de iterações** de antemão. O loop continua enquanto uma **condição específica for verdadeira**.
    * Você precisa que o loop continue até que uma **condição externa** (e.g., entrada do usuário, status de um sensor, leitura de um arquivo) mude.
    * A condição de parada é mais complexa e não diretamente ligada a um contador simples.

  Exemplos: Ler dados de um arquivo até o fim, aguardar uma entrada válida do usuário, simular um jogo até que o jogador perca.

-----

## 9\. Qual a diferença entre os comandos 'break' e 'continue'?

`break` e `continue` são comandos usados dentro de loops para alterar o fluxo de execução:

* **`break`**:

    * **Interrompe o loop completamente**.
    * A execução do programa salta para a primeira instrução **após o loop**.
    * Usado para sair de um loop prematuramente quando uma condição específica é satisfeita.

  <!-- end list -->

  ```dart
  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      break; // Sai do loop quando i é 5
    }
    print(i); // Imprime 1, 2, 3, 4
  }
  print('Loop finalizado.');
  ```

* **`continue`**:

    * **Pula a iteração atual** do loop.
    * A execução do programa salta para o **próximo ciclo do loop**, avaliando novamente a condição (para `while`) ou indo para a etapa de incremento/decremento (para `for`).
    * Usado para pular elementos ou situações específicas dentro de um loop sem interrompê-lo totalmente.

  <!-- end list -->

  ```dart
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      continue; // Pula a iteração quando i é 3
    }
    print(i); // Imprime 1, 2, 4, 5
  }
  print('Loop finalizado.');
  ```

-----

## 10\. Como posso usar 'break' para sair de um loop aninhado?

Por padrão, `break` sai apenas do **loop mais interno** em que ele está. Para sair de um loop aninhado (múltiplos loops, um dentro do outro) completamente, você pode usar **rótulos (labels)**.

Você define um rótulo antes do loop externo e usa `break` seguido do nome do rótulo.

```dart
outerLoop: for (int i = 0; i < 3; i++) {
  innerLoop: for (int j = 0; j < 3; j++) {
    print('i: $i, j: $j');
    if (i == 1 && j == 1) {
      print('Saindo de ambos os loops!');
      break outerLoop; // Sai do loop rotulado 'outerLoop'
    }
  }
}
print('Programa continua após loops aninhados.');
```

**Saída:**

```
i: 0, j: 0
i: 0, j: 1
i: 0, j: 2
i: 1, j: 0
i: 1, j: 1
Saindo de ambos os loops!
Programa continua após loops aninhados.
```

-----

## 11\. Em quais situações é útil usar o comando 'continue' em um loop?

O comando `continue` é útil em situações onde você precisa **pular uma ou mais iterações específicas** de um loop, sem interromper o loop por completo.

Situações comuns incluem:

* **Pular Valores Inválidos ou Indesejados**: Processar apenas elementos que atendem a certos critérios.

  ```dart
  List<int> notas = [7, 5, 8, 4, 9];
  for (int nota in notas) {
    if (nota < 6) {
      print('Nota $nota é insuficiente, pulando avaliação.');
      continue; // Pula para a próxima nota
    }
    print('Avaliando nota: $nota');
  }
  ```

* **Otimização**: Evitar a execução de código dispendioso ou desnecessário para certos casos.

  ```dart
  for (int i = 0; i < 1000; i++) {
    if (i % 2 != 0) { // Se for ímpar
      continue; // Pula a iteração, só processa pares
    }
    // Código complexo que só precisa ser executado para números pares
    print('Processando número par: $i');
  }
  ```

* **Tratamento de Erros/Exceções Lógicas**: Quando um erro específico ocorre para um item, mas você quer continuar processando os outros.

  ```dart
  List<String> arquivos = ['relatorio.txt', 'config.json', 'dados.csv', 'temp.tmp'];
  for (String arquivo in arquivos) {
    if (arquivo.endsWith('.tmp')) {
      print('Arquivo temporário $arquivo, ignorando.');
      continue;
    }
    print('Processando arquivo: $arquivo');
  }
  ```