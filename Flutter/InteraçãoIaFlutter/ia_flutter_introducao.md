## O que é o `MaterialApp` e seus parâmetros?

O **`MaterialApp`** é um widget central no Flutter que encapsula a funcionalidade do **Material Design**. Pense nele como o ponto de entrada do seu aplicativo, onde você define configurações globais como tema, navegação, título e localizações. Ele não apenas configura o visual, mas também fornece os widgets necessários para que seu app seja construído de acordo com as especificações do Material Design.

O `MaterialApp` possui diversos parâmetros, mas vamos focar nos mais importantes para começar:

* **`home`**: Este é, talvez, o parâmetro mais crucial. Ele define o **primeiro widget** que será exibido quando o aplicativo for iniciado. Geralmente, é um `Scaffold` que contém a estrutura visual da sua primeira tela.

  ```dart
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Minha Primeira Tela')),
      body: Center(child: Text('Olá, Flutter!')),
    ),
  )
  ```

* **`title`**: Uma `String` que descreve o propósito do aplicativo para o sistema operacional. É o título que aparece no gerenciador de tarefas do Android, por exemplo, ou na barra de título de uma janela de desktop.

  ```dart
  MaterialApp(
    title: 'Meu App Incrível',
    home: MyHomeScreen(),
  )
  ```

* **`theme`**: Define o **tema visual** padrão para todo o seu aplicativo. Você pode configurar cores primárias, secundárias, fontes, brilho e outras propriedades de estilo usando `ThemeData`.

  ```dart
  MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue, // Cor primária do app
      brightness: Brightness.light, // Tema claro
    ),
    home: MyHomeScreen(),
  )
  ```

* **`debugShowCheckedModeBanner`**: Um `bool` que controla a exibição da faixa "DEBUG" no canto superior direito do seu aplicativo em modo de depuração. Defina como `false` para removê-la em produção.

  ```dart
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomeScreen(),
  )
  ```

* **`routes`**: Um mapa (Map) de `String` para `WidgetBuilder` que define as **rotas nomeadas** do seu aplicativo. Isso permite navegar entre telas usando nomes, como `/home`, `/settings`, etc.

  ```dart
  MaterialApp(
    home: MyHomeScreen(),
    routes: {
      '/settings': (context) => SettingsScreen(),
      '/profile': (context) => ProfileScreen(),
    },
  )
  ```

* **`initialRoute`**: A rota que será mostrada quando o aplicativo iniciar, se você estiver usando `routes`. Se `home` for fornecido, `initialRoute` é ignorado.

-----

## Como funcionam os "imports" no Flutter?

Os "imports" no Flutter (e em Dart, a linguagem por trás do Flutter) funcionam como em muitas outras linguagens: eles servem para **trazer para o escopo do seu arquivo atual definições (classes, funções, variáveis) que estão em outros arquivos ou bibliotecas**.

No Flutter, você verá principalmente dois tipos de imports:

1.  **Imports de pacotes (`package:`):** Usados para importar código de pacotes externos que você adiciona ao seu projeto via `pubspec.yaml` (como `http`, `provider`, etc.) ou de pacotes internos do próprio Flutter (`material`, `cupertino`, `widgets`, etc.).

    ```dart
    import 'package:flutter/material.dart'; // Importa o pacote Material Design do Flutter
    import 'package:http/http.dart' as http; // Importa o pacote http, com um prefixo para evitar conflitos
    ```

2.  **Imports relativos (`../` ou caminho direto):** Usados para importar arquivos dentro do seu próprio projeto, referenciando o caminho relativo a partir do arquivo atual.

    ```dart
    import 'screens/home_screen.dart'; // Se este arquivo e 'home_screen.dart' estão na mesma pasta
    import '../models/user.dart';     // Se este arquivo está em 'lib/screens/' e 'user.dart' em 'lib/models/'
    ```

**Por que são importantes?** Eles permitem que você divida seu código em múltiplos arquivos e diretórios, tornando-o mais modular, organizado e fácil de gerenciar.

-----

## Explique o que é o Material Design e como ele é utilizado no Flutter.

**Material Design** é um sistema de design de código aberto desenvolvido pelo Google, que fornece diretrizes abrangentes para design visual, movimento e interação. Seu objetivo é criar experiências de usuário bonitas, consistentes e intuitivas em diferentes produtos e plataformas, imitando elementos do mundo físico como papel e tinta, com profundidade e sombras.

**Como ele é utilizado no Flutter:**

O Flutter é **altamente integrado** com o Material Design. A maioria dos widgets visuais fornecidos pelo framework Flutter (aqueles que você importa de `package:flutter/material.dart`) são implementações diretas das diretrizes do Material Design. Isso significa que, ao usar widgets como `AppBar`, `Scaffold`, `FloatingActionButton`, `Card`, etc., você está automaticamente construindo um aplicativo que segue as melhores práticas de design do Google. Essa integração facilita muito a criação de apps visualmente atraentes e consistentes sem precisar implementar cada detalhe de design do zero.

-----

## Quais são os principais widgets do Material Design disponíveis no Flutter?

O Flutter oferece uma rica coleção de widgets que implementam o Material Design. Aqui estão alguns dos mais comuns e fundamentais:

* **`Scaffold`**: O widget base para implementar a estrutura visual do Material Design (barra superior, inferior, menu lateral, etc.).
* **`AppBar`**: A barra de aplicativos na parte superior da tela, geralmente com título e botões.
* **`Text`**: Exibe uma string de texto.
* **`Icon`**: Exibe um ícone Material Design.
* **`Button`s (e suas variantes)**: `ElevatedButton`, `TextButton`, `OutlinedButton`, `FloatingActionButton (FAB)`.
* **`Card`**: Um painel de material com cantos arredondados e elevação, usado para agrupar conteúdo.
* **`Row` e `Column`**: Widgets para organizar outros widgets horizontalmente (`Row`) ou verticalmente (`Column`).
* **`Container`**: Um widget de uso geral para combinar funcionalidades de pintura, posicionamento e dimensionamento.
* **`Image`**: Exibe uma imagem.
* **`ListView`**: Um widget rolável para exibir uma lista de itens.
* **`TextField`**: Um campo de entrada de texto que permite ao usuário digitar.
* **`BottomNavigationBar`**: Uma barra de navegação que aparece na parte inferior da tela.
* **`Drawer`**: Um painel de navegação que desliza da borda da tela.
* **`SnackBar`**: Uma mensagem pequena e temporária que aparece na parte inferior da tela.
* **`Dialog`s**: Como `AlertDialog` e `SimpleDialog`, para interações com o usuário.

-----

## O que são widgets Stateless e quando devemos utilizá-los?

Um **`StatelessWidget`** é um widget que **não tem estado mutável** durante sua vida útil. Ele é completamente imutável, o que significa que suas propriedades (os dados que ele recebe) não podem mudar após sua criação. Ele apenas renderiza o que lhe foi dado no momento de sua construção.

**Quando utilizá-los?**
Utilize `StatelessWidget` quando o widget:

* **Não precisa mudar com o tempo**: Se o conteúdo ou a aparência do widget não vai variar após sua primeira renderização.
* **Não lida com interações do usuário que afetam seu próprio estado**: Se uma interação (como um clique) afeta o estado de outro widget ou do aplicativo como um todo, mas não o próprio widget.
* **Apenas exibe dados**: Atua como um "apresentador" de dados que recebe de um widget pai.

**Exemplos**: `Text` (se o texto é fixo), `Icon`, `Image` (se a imagem é estática), `AppBar`, `Padding`, `Row`, `Column`.

```dart
class TituloApp extends StatelessWidget {
  final String titulo; // Propriedade imutável

  const TituloApp({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
```

-----

## Explique o ciclo de vida de um widget Stateless.

O ciclo de vida de um `StatelessWidget` é bastante simples e consiste principalmente em uma fase:

1.  **Construção (`Constructor`)**: O widget é criado e recebe suas propriedades.
2.  **`build` (Método de Renderização)**: Este é o único método significativo que você sobrescreve. Ele é chamado sempre que o Flutter precisa desenhar ou redesenhar a parte da interface do usuário que este widget representa, com base nas propriedades recebidas. O método `build` é chamado novamente se o widget pai o reconstruir com novos dados.

-----

## Quais são as limitações dos widgets Stateless?

As limitações dos `StatelessWidget`s derivam de sua natureza imutável:

* **Não podem mudar seu próprio estado interno**: Se você precisar de um widget que mude sua própria aparência ou comportamento em resposta a eventos internos, um `StatelessWidget` não pode fazer isso por conta própria.
* **Não podem lidar com interações dinâmicas que afetam a si mesmos**: Um botão `StatelessWidget` pode ser clicado, mas não pode mudar sua cor para "pressionado" e depois voltar para "normal" internamente.
* **Não possuem ciclo de vida complexo**: Não há métodos como `initState` ou `dispose` para gerenciar recursos ou inicializações que dependam do tempo de vida do widget na árvore.

-----

## O que são widgets Stateful e quando devemos utilizá-los?

Um **`StatefulWidget`** é um widget que **pode ter estado mutável** durante sua vida útil. Ele possui um objeto `State` associado a ele, e é esse objeto `State` que detém o estado mutável e a lógica para reconstruir a interface do usuário quando o estado muda.

**Quando utilizá-los?**
Utilize `StatefulWidget` quando o widget:

* **Precisa mudar sua aparência ou comportamento** com base em interações do usuário (como um `Checkbox` ou um contador).
* **Precisa manter um estado que persiste ao longo do tempo**.
* **Lida com dados assíncronos** que afetam sua própria exibição (como resultados de requisições de rede).
* **Precisa gerenciar recursos** que exigem inicialização e descarte (como controladores de animação).

<!-- end list -->

```dart
class Contador extends StatefulWidget {
  const Contador({Key? key}) : super(key: key);

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _contador = 0; // Estado mutável

  void _incrementarContador() {
    setState(() { // Notifica o Flutter para reconstruir o widget
      _contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Contagem: $_contador', style: TextStyle(fontSize: 30)),
        ElevatedButton(
          onPressed: _incrementarContador,
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}
```

-----

## Explique o ciclo de vida de um widget Stateful.

O ciclo de vida de um `StatefulWidget` é mais complexo, focado no objeto `State` associado:

1.  **`createState()`**: Primeiro método chamado, retorna uma nova instância do objeto `State`. Chamado **uma única vez**.
2.  **`initState()`**: Chamado **uma única vez** quando o objeto `State` é inserido na árvore. Ideal para inicializar o estado, inscrever-se em streams, etc. Sempre chame `super.initState()`.
3.  **`didChangeDependencies()`**: Chamado após `initState()` e quando as dependências do widget mudam (ex: tema, media query).
4.  **`build()`**: Chamado **muitas vezes**. Responsável por descrever a UI com base no estado atual. Chamado após `initState()`, `didChangeDependencies()`, `didUpdateWidget()`, `setState()` e quando o `BuildContext` muda.
5.  **`didUpdateWidget(covariant T oldWidget)`**: Chamado quando o widget pai reconstrói este `StatefulWidget` com um novo objeto de configuração (propriedades do widget mudam).
6.  **`setState(VoidCallback fn)`**: **Método que você chama** para notificar o Flutter que o estado interno mudou e que o `build` precisa ser executado novamente.
7.  **`deactivate()`**: Chamado quando o widget é removido da árvore, mas pode ser temporário.
8.  **`dispose()`**: Chamado quando o objeto `State` e seu widget são **removidos permanentemente** da árvore. **Crucial para liberar recursos** (controladores, streams, etc.) para evitar vazamentos de memória.

-----

## Como o gerenciamento de estado é feito em widgets Stateful?

O gerenciamento de estado em `StatefulWidget`s é centralizado no **objeto `State`** associado a eles.

* O objeto `State` contém todas as **variáveis mutáveis** (os dados que podem mudar) que afetam a UI do widget.
* A única maneira correta de informar ao Flutter que o estado mudou e que a UI precisa ser atualizada é chamando o método **`setState(() { ... })`**.
* Toda e qualquer modificação em uma variável de estado que deve refletir na UI **deve ser feita dentro do callback de `setState`**. Quando `setState` é chamado, o Flutter marca o widget como "sujo" e agenda uma reconstrução do seu `build` method.

-----

## Como funciona o `setState` em Flutter?

O `setState` é o coração do gerenciamento de estado local em `StatefulWidget`s:

1.  **Notificação de Mudança**: Você chama `setState(() { ... })` para informar ao Flutter que o estado interno do seu widget foi alterado.
2.  **Marcação como "Sujo"**: O Flutter marca o elemento associado a esse `State` na árvore de elementos como "sujo", indicando que ele precisa ser reconstruído.
3.  **Agendamento de Reconstrução**: Uma nova renderização é agendada para o próximo *frame*.
4.  **Reexecução do `build`**: No próximo *frame*, o Flutter chama novamente o método `build()` do `State` correspondente.
5.  **Comparação e Renderização**: O Flutter compara a nova árvore de widgets com a anterior, identifica as diferenças e atualiza apenas as partes da UI que realmente mudaram, otimizando a performance.

**Importante**: As mudanças no estado **devem** ocorrer dentro da função de callback fornecida ao `setState`, caso contrário, a UI não será atualizada.

-----

## Quais cuidados tomar no gerenciamento de estado?

O gerenciamento de estado é crítico. Cuidados a tomar:

1.  **Use `setState` Apenas Onde Necessário**: Evite chamadas excessivas para otimizar a performance.
2.  **Mantenha o Estado Local Mínimo**: Para estados complexos ou compartilhados, considere soluções de gerenciamento de estado mais robustas (Provider, BLoC, Riverpod, etc.).
3.  **Não Faça Operações Pesadas no `build`**: Evite lógica de negócio complexa, chamadas de rede ou cálculos pesados diretamente no `build` para não travar a UI. Realize-os em `initState` ou funções separadas.
4.  **Libere Recursos em `dispose`**: Se alocou recursos (controladores, streams), **sempre libere-os em `dispose()`** para evitar vazamentos de memória.
5.  **Cuidado com `BuildContext` Assíncronos**: Ao usar `await` em funções assíncronas, verifique sempre se o widget ainda está montado (`if (!mounted) return;`) antes de chamar `setState` ou interagir com o `BuildContext`.

-----

## Quais as principais diferenças entre widgets Stateless e Stateful?

| Característica         | `StatelessWidget`                               | `StatefulWidget`                                     |
| :--------------------- | :---------------------------------------------- | :--------------------------------------------------- |
| **Estado Interno** | **Não possui** estado mutável interno.         | **Possui** estado mutável interno (via objeto `State`). |
| **Imutabilidade** | Completamente **imutável**.                     | O widget em si é imutável, mas seu `State` é mutável. |
| **Atualização da UI** | A UI é atualizada apenas se o **pai o reconstrói** com novas propriedades. | A UI pode ser atualizada internamente chamando **`setState`**. |
| **Métodos de Ciclo de Vida** | Apenas o `build()`.                           | Possui um ciclo de vida mais completo (`initState()`, `build()`, `dispose()`, etc.). |
| **Propósito** | Exibir informações **estáticas** ou que dependem apenas de dados passados pelo pai. | Exibir informações que **mudam ao longo do tempo** devido a interações do usuário, dados assíncronos, etc. |
| **Exemplos** | `Text`, `Icon`, `Padding`, `Row`, `AppBar`.       | `Checkbox`, `TextField`, `Slider`, um contador.      |

A escolha entre `StatelessWidget` e `StatefulWidget` depende inteiramente da necessidade do seu widget de ter um estado interno que pode ser alterado e que deve refletir na interface do usuário. Se não muda, é `Stateless`. Se muda, é `Stateful`.