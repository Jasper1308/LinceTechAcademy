import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class Args {
  final int id;
  final String nome;

  Args(this.id, this.nome);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Tela1(),
        Tela2.routeName : (context) => Tela2(),
        '/tela3' : (context) => Tela3(),
      },
    );
  }
}

class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tela 1'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tela2',
                arguments: Args(1, 'Jaspion'));
              },
              child: Text('Ir para tela 2')
          ),
        ),
      ),
    );
  }
}

class Tela2 extends StatelessWidget {
  static const routeName = '/tela2';

  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Args;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Tela 2' + args.nome),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tela3');
                  },
                  child: Text('Ir para tela 3')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retornar tela 1')
              ),
            ],
          )
        ),
      ),
    );
  }
}


class Tela3 extends StatelessWidget {
  const Tela3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tela 3'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('retornar')
          ),
        ),
      ),
    );
  }
}