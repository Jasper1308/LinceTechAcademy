# Variáveis em Dart: Boas Práticas e Uso Essencial

Este documento resume as diretrizes para declarar variáveis em Dart, cobrindo segurança de nulos, imutabilidade e manipulação de tipos básicos.

---

## 1. Boas Práticas e o Que Evitar ao Declarar Variáveis

* **Nomes Descritivos:** Use nomes claros (`idadeCliente`, não `i`).
* **Tipagem Forte:** Prefira **`var`** quando o tipo é óbvio (`var nome = 'Alice';`) e o **tipo explícito** (`String nome = 'Alice';`) para clareza. Evite `List nomes = ...` (que cria `List<dynamic>`).
* **Imutabilidade:**
    * Use **`final`** para valores que serão inicializados **uma vez** em tempo de execução e não mudarão (`final DateTime agora = DateTime.now();`).
    * Use **`const`** para valores que são **constantes em tempo de compilação** (`const double PI = 3.14;`). Isso otimiza performance e memória.
* **Inicialização:** Sempre que possível, inicialize variáveis na declaração (`int contador = 0;`).
* **Evite:** Nomes genéricos, reatribuir `final`/`const`, excesso de variáveis globais.

---

## 2. Variáveis Nulas (`null safety`) e Modificador `late`

Dart possui `null safety` para evitar erros de nulidade em tempo de execução.

### Cuidados com Variáveis Nulas
* **Declare Nulável:** Se uma variável pode ser `null`, use `?` após o tipo (ex: `String? nomeDoMeio;`).
* **Verifique a Nulidade:** Antes de usar, verifique se não é `null` (`if (nome != null)`), ou use `?.` (chamada condicional) ou `??` (valor padrão).
* **`!` (Null Assertion Operator):** Use `!` **apenas** quando tiver certeza absoluta de que o valor não é nulo. O uso indevido causará um erro em tempo de execução.

### Quando Usar Nulas vs. `late`
* **Nulas (`Tipo?`):** Use quando a ausência de um valor (`null`) é uma condição **válida e esperada** para a variável em algum ponto.
* **`late`:** Use quando a variável **não pode ser inicializada na declaração**, mas você **garante** que ela será inicializada **antes do primeiro uso**.
    * **Benefícios de `late`:**
        * **Inicialização Preguiçosa (Lazy):** O valor é computado apenas no primeiro acesso, economizando recursos.
        * **Quebra de Dependências:** Permite inicializar propriedades que dependem de outras que ainda não estão prontas no construtor.
        * **Código Mais Limpo:** Evita declarar como nulável algo que você sabe que eventualmente terá um valor não nulo.

---

## 3. `final` vs. `const` e Seus Benefícios

Ambos criam variáveis imutáveis, mas com diferenças importantes:

| Característica | `final`                                  | `const`                                                |
| :------------- | :--------------------------------------- | :----------------------------------------------------- |
| **Quando?** | Inicializada uma vez em **tempo de execução** | Inicializada em **tempo de compilação** |
| **Conteúdo?** | Pode ser resultado de função, data atual | Deve ser literal ou outra constante (conhecido antes da execução) |
| **Instância?** | Cria uma nova instância a cada execução  | Reutiliza a **mesma instância canônica** (otimização de memória) |

### Por Que Usar `final` e `const`?
* **Imutabilidade:** Previne alterações acidentais, tornando o código mais seguro e previsível.
* **Previsibilidade:** Facilita o raciocínio sobre o estado do programa e a depuração.
* **Performance:** `const` oferece otimizações significativas, reutilizando valores em memória. `final` contribui para a segurança do código.
* **Clareza:** Comunica a intenção de que o valor é fixo.

---

## 4. Métodos Comuns para Tipos Básicos

### Métodos de `String`
Strings possuem muitos métodos para manipulação de texto:
* **Análise:** `isEmpty`, `isNotEmpty`, `contains()`, `startsWith()`, `endsWith()`.
* **Transformação:** `toLowerCase()`, `toUpperCase()`, `trim()`, `substring()`, `replaceFirst()`, `replaceAll()`, `split()`.
* **Pesquisa:** `indexOf()`, `lastIndexOf()`.
* **Propriedade:** `length`.

### Métodos de `int` (e `num` - sua classe pai)
Inteiros focam em operações numéricas:
* **Propriedades:** `isEven`, `isOdd`, `isFinite`, `isInfinite`, `isNaN`, `isNegative`, `sign`.
* **Conversão:** `abs()`, `toDouble()`, `toString()`, `toRadixString()` (para bases como binário/hexadecimal).
* **Matemática:** `gcd()` (maior divisor comum), `modInverse()`, `modPow()`.
* **Operadores:** `+`, `-`, `*`, `/`, `~/` (divisão inteira), `%`.

---