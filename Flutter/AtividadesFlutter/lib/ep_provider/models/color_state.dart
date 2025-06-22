import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color_enum.dart';

class ColorState with ChangeNotifier{
  Cores _backgroundColor = Cores.white;
  Cores _appBarColor = Cores.blue;
  Cores _cardColor = Cores.white;

  Cores get backgroundColor => _backgroundColor;
  Cores get appBarColor => _appBarColor;
  Cores get cardColor => _cardColor;

  void changeColor(Cores backgroundColor, Cores appBarColor){
    _backgroundColor = backgroundColor;
    _appBarColor = appBarColor;
    notifyListeners();
  }

  void changeCardColor(Cores cardColor){
    _cardColor = cardColor;
    notifyListeners();
  }
}