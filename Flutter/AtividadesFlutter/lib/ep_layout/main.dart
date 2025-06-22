import 'package:ap1/ep_layout/screens/calculatorScreen.dart';
import 'package:ap1/ep_layout/screens/convertScreen.dart';
import 'package:ap1/ep_layout/screens/moneyConvertScreen.dart';
import 'package:flutter/material.dart';
import '../apf6_funcoes/screens/home_screen.dart';


final darkBlue = Color.fromRGBO(0, 20, 70, 1);
final blue = Color.fromRGBO(19, 75, 176, 1);

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: <String, WidgetBuilder> {
      '/' : (BuildContext context) => Home(),
      '/unidades' : (BuildContext context) => ConvertUnit(),
      '/moeda' : (BuildContext context) => MoneyConvert(),
      '/calculadora' : (BuildContext context) => Calculator(),
    },
  ));
}