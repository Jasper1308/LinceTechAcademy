import 'package:flutter/material.dart';

final darkBlue = Color.fromRGBO(0, 20, 70, 1);
final blue = Color.fromRGBO(19, 75, 176, 1);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: darkBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/lince_tech_academy.png', scale: 8,),
            Padding(padding: EdgeInsets.all(25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/moeda'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                          (states) {
                        return blue;
                      },
                    ),
                    fixedSize: WidgetStateProperty.resolveWith(
                          (states) {
                        return Size(130, 130);
                      },
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/moeda.png'),
                      Text('Conversor de moedas', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/unidades"),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                          (states) {
                        return blue;
                      },
                    ),
                    fixedSize: WidgetStateProperty.resolveWith(
                          (states) {
                        return Size(130, 130);
                      },
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/regua.png'),
                      Text('Conversor de unidades', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () => print('Ola'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                      (states) {
                    return blue;
                  },
                ),
                fixedSize: WidgetStateProperty.resolveWith(
                      (states) {
                    return Size(270, 130);
                  },
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                ),
              ),
              child: Row(
                children: [
                  Image.asset('assets/calculadora.png'),
                  Text(
                    'Calculadora',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}