import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorState with ChangeNotifier{
  static const String _backgroundColorKey = 'backgroundColor';
  static const String _appBarColorKey = 'appBarColor';

  Color _backgroundColor = Colors.white;
  Color _appBarColor = Colors.blue;

  Color get backgroundColor => _backgroundColor;
  Color get appBarColor => _appBarColor;

  ColorState(){

  }

  void changeColor(Color backgroundColor, Color appBarColor){
    _backgroundColor = backgroundColor;
    _appBarColor = appBarColor;
    notifyListeners();
  }

}