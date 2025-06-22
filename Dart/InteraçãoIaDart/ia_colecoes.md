# Coleções em Dart: Listas, Mapas e Sets

---

## 1. Listas (`List<E>`)

Coleções ordenadas de objetos, acessadas por índice numérico.

### Boas Práticas
* **Tipagem Forte:** Sempre use o tipo (`List<String>`) para segurança.
* **Imutabilidade:** Use **`const`** para listas fixas em tempo de compilação, e **`final`** para listas que não são reatribuídas (mas podem ter seu conteúdo modificado).
* **Métodos de Coleção:** Prefira `map`, `where`, `forEach` em vez de loops `for` tradicionais para clareza.
* **Cuidado ao Modificar na Iteração:** Evite adicionar ou remover elementos de uma lista enquanto a percorre, pois isso pode causar erros.

### Performance
* **Pré-alocar Tamanho:** Se souber o número de elementos, crie a lista com tamanho fixo (`List.filled`) para evitar realocações de memória.
* **Evite Remoções/Adições no Início:** Operações no início de listas grandes (`insert(0, ...)`, `removeAt(0)`) são ineficientes. Considere `dart:collection` `Queue` para isso.
* **Iterables "Preguiçosos":** Use `Iterable` (retornado por `map`, `where`) e chame `.toList()` apenas quando precisar da lista completa, economizando recursos.

### O Que Não Fazer
* Declarar listas sem tipo (`List lista = ...`), perdendo a segurança do Dart.
* Modificar a lista enquanto itera sobre ela diretamente.
* Acessar índices que não existem na lista (ex: `lista[10]` em uma lista de 5 itens) para evitar `RangeError`.

---

## 2. Mapas (`Map<K, V>`)

Coleções de pares chave-valor, onde cada **chave** é **única**.

### Quando Usar Listas vs. Mapas
* **Listas:** Ordem importa, acesso por índice numérico, ou coleção de itens homogêneos (com ou sem duplicatas).
* **Mapas:** Acesso por uma **chave única** (ex: ID, nome), a ordem não importa tanto, ideal para dados associativos.

### Boas Práticas
* **Tipagem Forte:** Sempre tipar chaves e valores (`Map<String, int>`).
* **Imutabilidade:** Use `const` ou `final` conforme a necessidade.
* **Acesso Seguro:** Verifique a existência da chave (`mapa.containsKey('chave')` ou `mapa['chave'] ?? valorPadrao`) antes de acessar para evitar `null`.
* **`putIfAbsent`:** Use para adicionar um valor apenas se a chave não existir.
* **Iteração Eficiente:** Use `forEach` ou itere sobre `mapa.keys` e `mapa.values`.

---

## 3. Sets (`Set<E>`)

Coleções de elementos **únicos** e **não ordenados**.

### Métodos Auxiliares Comuns (Listas e Sets)
Ambos herdam de `Iterable` e compartilham métodos como:
* `length`, `isEmpty`, `isNotEmpty`
* `first`, `last`, `single`
* `forEach`, `map`, `where`, `any`, `every`
* `toList()`, `toSet()`

### Métodos Específicos de Set
* `add(E value)`: Adiciona um elemento. Se já existe, nada acontece.
* `addAll(Iterable<E> iterable)`: Adiciona múltiplos elementos.
* `remove(Object? value)`: Remove um elemento específico.
* `union(Set<E> other)`: Retorna um novo Set com todos os elementos de ambos.
* `intersection(Set<Object?> other)`: Retorna um novo Set com elementos comuns a ambos.
* `difference(Set<Object?> other)`: Retorna um novo Set com elementos que estão no primeiro, mas não no segundo.

### Cuidados ao Usar Sets
* **Unicidade Garantida:** `Set` assegura que não há duplicatas. Adicionar um elemento existente é ignorado.
* **Sem Ordem Fixa:** Não dependa da ordem dos elementos em um `Set` (exceto `LinkedHashSet`, que mantém a ordem de inserção).
* **Hashing (`hashCode` e `==`):** Ao usar objetos customizados, **você deve sobrescrever `hashCode` e `==`** na sua classe. Isso é crucial para que o `Set` identifique corretamente a unicidade dos objetos.

---

## 4. `elementAtOrNull` (Dart 3.0+)

**`E? elementAtOrNull(int index)`**

* **Descrição:** Retorna o elemento no `index` especificado de qualquer `Iterable` (incluindo Listas e Sets).
* **Segurança:** Se o `index` estiver fora dos limites, ele retorna **`null`** em vez de lançar um `RangeError`, tornando o acesso mais seguro e prático.

**Exemplo:**
```dart
List<String> itens = ['Maçã', 'Banana'];
print(itens.elementAtOrNull(0)); // Saída: Maçã
print(itens.elementAtOrNull(5)); // Saída: null