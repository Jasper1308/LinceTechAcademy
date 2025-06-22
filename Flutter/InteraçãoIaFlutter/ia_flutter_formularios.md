## O que é um widget `TextField` em Flutter e para que ele serve?

O widget **`TextField`** em Flutter é um componente de interface de usuário que permite ao usuário **inserir texto** em um aplicativo. Ele serve como um campo de entrada onde as pessoas podem digitar, editar e visualizar informações de texto.

**Para que ele serve?**
O `TextField` é fundamental para qualquer aplicativo que precise de interação com o usuário para entrada de dados. Ele é usado em diversas situações, como:

* **Formulários de Login/Cadastro**: Para que o usuário insira nome de usuário, email e senha.
* **Campos de Busca**: Onde o usuário digita termos para pesquisar.
* **Comentários/Mensagens**: Para digitar mensagens em chats ou caixas de comentários.
* **Campos de Dados Diversos**: Endereços, telefones, quantidades, etc.

Ele oferece funcionalidades básicas como digitação, seleção de texto, copiar, colar e cortas, e pode ser configurado com teclados específicos (numérico, email, etc.).

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Digite seu nome',
    hintText: 'Ex: João Silva',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.text,
)
```

-----

## Como posso obter o valor digitado pelo usuário em um `TextField`?

A maneira mais comum e recomendada de obter o valor digitado em um `TextField` é usando um **`TextEditingController`**.

1.  **Declare um `TextEditingController`**:
    Você deve declarar uma instância de `TextEditingController` dentro do `State` do seu `StatefulWidget` (já que o valor do texto é um estado que pode mudar).

    ```dart
    class MyFormScreenState extends State<MyFormScreen> {
      final TextEditingController _nomeController = TextEditingController();

      @override
      void dispose() {
        // MUITO IMPORTANTE: Descartar o controller quando o widget não for mais necessário
        _nomeController.dispose();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Obtendo Texto')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController, // Atribui o controller ao TextField
                  decoration: InputDecoration(labelText: 'Seu Nome'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Obtém o valor atual do TextField
                    String nomeDigitado = _nomeController.text;
                    print('Nome digitado: $nomeDigitado');
                    // Você pode usar o valor aqui para lógica de negócio, exibição, etc.
                  },
                  child: Text('Obter Nome'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```

2.  **Acesse o valor**:
    O valor atual digitado pelo usuário estará disponível na propriedade `.text` do seu `TextEditingController`.

3.  **Descarte o Controller (`dispose`)**:
    É **crucial** descartar (`dispose()`) o `TextEditingController` quando o `StatefulWidget` for descartado (no método `dispose()` do `State`). Isso libera recursos e evita vazamentos de memória.

**Alternativa (menos comum para obter valor, mais para reagir a cada mudança)**:
Você também pode usar o callback `onChanged` do `TextField` para obter o valor a cada mudança de caractere. Isso é útil para validação em tempo real ou para filtros de busca.

```dart
TextField(
  onChanged: (text) {
    print('Texto atual: $text');
    // Você pode armazenar 'text' em uma variável de estado com setState
  },
  decoration: InputDecoration(labelText: 'Digite algo'),
)
```

No entanto, para obter o valor final quando uma ação é confirmada (ex: clicar num botão "Enviar"), o `TextEditingController` é a abordagem mais direta e eficiente.

-----

## Qual a diferença entre um `TextField` e um `TextFormField`?

A principal diferença entre `TextField` e `TextFormField` reside no foco em **validação de formulário**.

* **`TextField`**:

    * É o widget básico para entrada de texto.
    * Fornece todas as funcionalidades para digitar, editar e exibir texto.
    * **Não tem suporte embutido para validação de formulário ou estados de erro.** Você teria que implementar a lógica de validação e exibição de erros manualmente.
    * Útil para campos de entrada simples que não fazem parte de um formulário que precisa de validação complexa ou submissão.

* **`TextFormField`**:

    * É um `TextField` que é especificamente projetado para ser usado dentro de um widget **`Form`**.
    * Vem com suporte embutido para **validação de entrada** (através da propriedade `validator`) e gerenciamento de estado de erro.
    * Pode ser facilmente integrado com os métodos `Form.of(context).validate()` e `Form.of(context).save()`.
    * Quando um erro de validação ocorre, ele exibe automaticamente o `errorText` (definido no `validator`) abaixo do campo.

**Quando usar qual:**

* Use **`TextField`** para campos de busca, caixas de diálogo de entrada rápida, ou qualquer campo de texto que **não faça parte de um formulário maior** que precisa de validação e submissão em grupo.
* Use **`TextFormField`** **sempre que você estiver construindo um formulário** onde a validação de entrada do usuário é crucial antes de processar ou enviar os dados. Ele simplifica muito o processo de validação.

**Exemplo de `TextFormField` com validação**:

```dart
final _formKey = GlobalKey<FormState>(); // Chave para o formulário

// ... dentro do build de um StatefulWidget
Form(
  key: _formKey, // Atribua a chave ao Form
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu email.';
          }
          if (!value.contains('@')) {
            return 'Email inválido.';
          }
          return null; // Retorna null se a validação for bem-sucedida
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) { // Aciona a validação de todos os TextFormField no formulário
            // Se o formulário é válido, processe os dados
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Formulário válido!')),
            );
          }
        },
        child: const Text('Enviar'),
      ),
    ],
  ),
)
```

-----

## Quais parâmetros importantes do `TextField`?

O `TextField` possui muitos parâmetros para personalização e controle. Aqui estão alguns dos mais importantes:

* **`controller`**: O **`TextEditingController`** para obter/definir o valor do texto e controlar a seleção. (MUITO IMPORTANTE)
* **`decoration`**: Aceita um objeto **`InputDecoration`** para estilizar o campo. Este é um dos parâmetros mais usados e poderosos. Dentro de `InputDecoration`, você pode definir:
    * `labelText`: Um rótulo flutuante.
    * `hintText`: Texto de dica que aparece quando o campo está vazio.
    * `border`: O estilo da borda (ex: `OutlineInputBorder()`, `UnderlineInputBorder()`).
    * `prefixIcon`, `suffixIcon`: Ícones antes e depois do texto.
    * `helperText`, `errorText`: Textos auxiliares e de erro.
    * `filled`, `fillColor`: Para campos com preenchimento de cor.
* **`keyboardType`**: Define o tipo de teclado a ser exibido (ex: `TextInputType.emailAddress`, `TextInputType.number`, `TextInputType.phone`, `TextInputType.multiline`).
* **`obscureText`**: Um `bool` que, se `true`, oculta o texto digitado (ótimo para senhas).
* **`onChanged`**: Um callback que é invocado a cada mudança no texto.
* **`onSubmitted`**: Um callback que é invocado quando o usuário pressiona o botão "Enter" ou "Concluir" no teclado.
* **`style`**: Um `TextStyle` para definir a fonte, cor, tamanho do texto digitado.
* **`textAlign`**: Alinhamento horizontal do texto (`TextAlign.left`, `TextAlign.center`, etc.).
* **`maxLines`**: O número máximo de linhas para o `TextField`. `null` (padrão) ou `1` para uma única linha. Se `null`, ele se expandirá verticalmente.
* **`minLines`**: O número mínimo de linhas para o `TextField`. Usado junto com `maxLines` para campos de texto multi-linha com altura inicial mínima.
* **`readOnly`**: Se `true`, o usuário não pode editar o texto, mas ainda pode selecioná-lo e copiá-lo.
* **`enabled`**: Se `false`, o campo é desativado e não editável.
* **`autofocus`**: Se `true`, o campo ganha foco automaticamente quando o widget é construído.

-----

## O que significa validar um campo de texto em Flutter?

Validar um campo de texto em Flutter significa **verificar se o valor digitado pelo usuário atende a certos critérios ou regras** antes de ser processado ou enviado. O objetivo é garantir a integridade dos dados e fornecer feedback claro ao usuário sobre entradas inválidas.

**Exemplos de regras de validação:**

* **Obrigatório**: O campo não pode estar vazio.
* **Formato**: O email deve ter formato de email válido, o telefone deve ter o número correto de dígitos, a data deve seguir um padrão.
* **Intervalo**: Um número deve estar entre X e Y.
* **Comprimento**: A senha deve ter no mínimo 8 caracteres.
* **Confirmação**: A senha e a confirmação de senha devem ser idênticas.
* **Único**: Um nome de usuário ou email já não deve existir no sistema (requer validação assíncrona).

**Como funciona a validação com `TextFormField`:**

* A propriedade `validator` de um `TextFormField` aceita uma função que recebe o valor atual do campo (`String? value`).
* Esta função deve **retornar `null` se o valor for válido**.
* Se o valor for inválido, a função deve **retornar uma `String`** que será exibida como uma mensagem de erro abaixo do campo.
* A validação é acionada manualmente, geralmente por um botão "Enviar", chamando `_formKey.currentState!.validate()`.

<!-- end list -->

```dart
// Exemplo de função validadora
String? _validarSenha(String? value) {
  if (value == null || value.isEmpty) {
    return 'A senha é obrigatória.';
  }
  if (value.length < 6) {
    return 'A senha deve ter no mínimo 6 caracteres.';
  }
  return null; // Válido
}

TextFormField(
  decoration: InputDecoration(labelText: 'Senha'),
  obscureText: true,
  validator: _validarSenha, // Atribui a função validadora
)
```

-----

## Qual a diferença entre validação síncrona e assíncrona?

A diferença reside no momento e na forma como a verificação de validação é realizada:

* **Validação Síncrona**:

    * A validação ocorre **imediatamente** e os resultados são retornados instantaneamente.
    * Não envolve operações que levam tempo (como requisições de rede ou acesso a banco de dados).
    * É feita com base nas informações disponíveis localmente (ex: se o campo está vazio, se o formato é de email, se tem um certo comprimento).
    * No `TextFormField`, a função `validator` é um exemplo de validação síncrona. Ela retorna `String?` imediatamente.

  <!-- end list -->

  ```dart
  // Exemplo de validação síncrona:
  validator: (value) {
    if (value!.isEmpty) {
      return 'Campo não pode ser vazio.'; // Retorna String imediatamente
    }
    return null; // Retorna null imediatamente
  }
  ```

* **Validação Assíncrona**:

    * A validação envolve uma operação que **leva tempo** para ser concluída (ex: verificar se um nome de usuário já existe no servidor, validar um CEP com uma API externa).
    * A função de validação retorna um **`Future<String?>`**, indicando que o resultado estará disponível em algum momento no futuro.
    * `TextFormField` possui uma propriedade `autovalidateMode` que pode ser usada para disparar a validação assíncrona. No entanto, o `TextFormField` padrão não tem um `asyncValidator`. Para validação assíncrona com `TextFormField`, você geralmente fará a chamada assíncrona em `onChanged` e gerenciará o `errorText` via `setState`, ou usará um pacote de formulário mais avançado.

  <!-- end list -->

  ```dart
  // Conceito de validação assíncrona (não diretamente no validator do TextFormField padrão)
  Future<String?> _validarUsuarioUnico(String? usuario) async {
    await Future.delayed(Duration(seconds: 2)); // Simula uma chamada de rede
    if (usuario == 'admin') {
      return 'Este usuário já existe.'; // Retorna Future<String>
    }
    return null; // Retorna Future<null>
  }
  ```

  Para implementar validação assíncrona no Flutter, você geralmente precisará de uma lógica mais elaborada, talvez usando um `StatefulWidget` para gerenciar o estado de carregamento/erro e atualizar o `errorText` do `InputDecoration` do `TextField` ou `TextFormField`.

-----

## O que é um widget `CheckBox` em Flutter e para que ele serve?

O widget **`Checkbox`** em Flutter é um controle de interface de usuário que permite ao usuário **selecionar ou desmarcar uma única opção** em uma lista. Ele representa um estado binário: ligado (marcado) ou desligado (desmarcado).

**Para que ele serve?**
`Checkbox` é usado para:

* **Seleção de Múltiplas Opções**: Em uma lista de opções, o usuário pode marcar várias caixas de seleção, pois cada `Checkbox` funciona de forma independente.
* **Aceitação de Termos**: "Eu aceito os termos e condições".
* **Ativar/Desativar Configurações**: Opções como "Lembrar-me", "Receber notificações".

O `Checkbox` é um **`StatefulWidget`** em sua essência, pois seu estado (marcado/desmarcado) muda.

```dart
class MyCheckboxScreen extends StatefulWidget {
  const MyCheckboxScreen({Key? key}) : super(key: key);

  @override
  State<MyCheckboxScreen> createState() => _MyCheckboxScreenState();
}

class _MyCheckboxScreenState extends State<MyCheckboxScreen> {
  bool _isChecked = false; // Estado do Checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkbox Exemplo')),
      body: Center(
        child: Row(
          children: [
            Checkbox(
              value: _isChecked, // Valor atual do checkbox
              onChanged: (bool? newValue) { // Callback chamado quando o valor muda
                setState(() {
                  _isChecked = newValue!; // Atualiza o estado
                });
              },
            ),
            const Text('Aceito os termos e condições'),
          ],
        ),
      ),
    );
  }
}
```

-----

## Como posso alterar a cor e a forma de um `CheckBox`?

Você pode customizar a cor e a forma de um `CheckBox` usando suas propriedades e o `ThemeData`.

**Propriedades do `Checkbox`:**

* **`activeColor`**: A cor do preenchimento quando o `Checkbox` está marcado.
  ```dart
  Checkbox(
    value: _isChecked,
    onChanged: (val) { setState(() { _isChecked = val!; }); },
    activeColor: Colors.green, // Cor de preenchimento quando marcado
  )
  ```
* **`checkColor`**: A cor do ícone de "check" (a marca de seleção).
  ```dart
  Checkbox(
    value: _isChecked,
    onChanged: (val) { setState(() { _isChecked = val!; }); },
    activeColor: Colors.blue,
    checkColor: Colors.yellow, // Cor da marca de seleção
  )
  ```
* **`fillColor`**: Define a cor de preenchimento do checkbox em diferentes estados. Permite mais controle que `activeColor`. Aceita um `MaterialStateProperty<Color?>`.
  ```dart
  Checkbox(
    value: _isChecked,
    onChanged: (val) { setState(() { _isChecked = val!; }); },
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.purple; // Cor quando selecionado
      }
      return Colors.grey; // Cor quando não selecionado
    }),
  )
  ```
* **`shape`**: Define a forma da borda do `Checkbox`. Você pode usar `RoundedRectangleBorder` para cantos arredondados, por exemplo.
  ```dart
  Checkbox(
    value: _isChecked,
    onChanged: (val) { setState(() { _isChecked = val!; }); },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Cantos arredondados
  )
  ```
* **`side`**: A cor e largura da borda quando o checkbox não está marcado.
  ```dart
  Checkbox(
    value: _isChecked,
    onChanged: (val) { setState(() { _isChecked = val!; }); },
    side: BorderSide(color: Colors.red, width: 2), // Borda vermelha de 2px
  )
  ```

**Customização Global com `ThemeData`**:
Você pode definir o estilo padrão de todos os CheckBoxes no seu aplicativo no `MaterialApp` usando `CheckboxThemeData` dentro do `ThemeData`.

```dart
MaterialApp(
  theme: ThemeData(
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.green), // Cor padrão para todos os Checkboxes
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  home: MyCheckboxScreen(),
)
```

-----

## O que é um widget `Radio` em Flutter e qual sua aplicabilidade?

O widget **`Radio`** em Flutter é um controle de interface de usuário que permite ao usuário **selecionar uma única opção de um conjunto de opções mutuamente exclusivas**. Diferente do `Checkbox`, onde você pode marcar vários, com os `Radio` buttons, escolher um desmarca automaticamente qualquer outro na mesma *group*.

**Applicabilidade**:
`Radio` buttons são usados para:

* **Seleção de Uma Única Opção**: "Selecione seu sexo" (Masculino/Feminino/Outro), "Método de pagamento" (Cartão/Boleto/Pix), "Dificuldade" (Fácil/Médio/Difícil).
* **Escolhas Exclusivas**: Onde apenas uma escolha é permitida em um determinado grupo.

O `Radio` também é um **`StatefulWidget`** em sua essência.

```dart
enum Genero { masculino, feminino, outro } // Exemplo de enum para o grupo

class MyRadioScreen extends StatefulWidget {
  const MyRadioScreen({Key? key}) : super(key: key);

  @override
  State<MyRadioScreen> createState() => _MyRadioScreenState();
}

class _MyRadioScreenState extends State<MyRadioScreen> {
  Genero? _generoSelecionado; // Estado para armazenar a opção selecionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radio Button Exemplo')),
      body: Column(
        children: <Widget>[
          RadioListTile<Genero>( // RadioListTile é comum para agrupar Radio com texto
            title: const Text('Masculino'),
            value: Genero.masculino,
            groupValue: _generoSelecionado, // Valor do grupo (quem está selecionado)
            onChanged: (Genero? value) {
              setState(() {
                _generoSelecionado = value;
              });
            },
          ),
          RadioListTile<Genero>(
            title: const Text('Feminino'),
            value: Genero.feminino,
            groupValue: _generoSelecionado,
            onChanged: (Genero? value) {
              setState(() {
                _generoSelecionado = value;
              });
            },
          ),
          RadioListTile<Genero>(
            title: const Text('Outro'),
            value: Genero.outro,
            groupValue: _generoSelecionado,
            onChanged: (Genero? value) {
              setState(() {
                _generoSelecionado = value;
              });
            },
          ),
          Text('Gênero selecionado: ${_generoSelecionado?.name ?? 'Nenhum'}'),
        ],
      ),
    );
  }
}
```

Para que os `Radio` buttons funcionem como um grupo (selecionando apenas um por vez), todos eles devem ter o mesmo `groupValue` e um `value` único que os identifique. Quando um `Radio` é selecionado, seu `value` é atribuído ao `groupValue`.

-----

## Como posso alterar a cor e a forma de um Rádio?

Assim como o `Checkbox`, você pode customizar a cor e a forma de um `Radio` usando suas propriedades e o `ThemeData`.

**Propriedades do `Radio`:**

* **`activeColor`**: A cor do ponto interno do rádio quando ele está selecionado.
  ```dart
  Radio<int>(
    value: 1,
    groupValue: _selectedValue,
    onChanged: (val) { setState(() { _selectedValue = val; }); },
    activeColor: Colors.deepOrange, // Cor do ponto quando selecionado
  )
  ```
* **`fillColor`**: Define a cor de preenchimento do rádio em diferentes estados. Aceita um `MaterialStateProperty<Color?>`.
  ```dart
  Radio<int>(
    value: 1,
    groupValue: _selectedValue,
    onChanged: (val) { setState(() { _selectedValue = val; }); },
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green; // Cor do ponto quando selecionado
      }
      return Colors.red; // Cor do círculo quando não selecionado (geralmente a borda)
    }),
  )
  ```
* **`overlayColor`**: A cor da animação de *splash* (toque) quando o rádio é pressionado.
* **`splashRadius`**: O raio do efeito de *splash*.

**Forma**:
O `Radio` button tem uma forma circular fixa por padrão, que é parte do seu design intrínseco no Material Design. Diferente do `Checkbox`, ele **não possui uma propriedade `shape`** para alterar sua forma fundamental de círculo. Para alterar a forma de um radio button, você teria que criar um widget customizado do zero, o que geralmente não é recomendado se você quiser manter a conformidade com o Material Design.

**Customização Global com `ThemeData`**:
Você pode definir o estilo padrão de todos os Radio buttons no seu aplicativo no `MaterialApp` usando `RadioThemeData` dentro do `ThemeData`.

```dart
MaterialApp(
  theme: ThemeData(
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.blue), // Cor padrão para todos os Radios
      overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
    ),
  ),
  home: MyRadioScreen(),
)
```

Ao usar `RadioListTile`, as propriedades de cor se aplicam ao `Radio` embutido.