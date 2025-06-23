import 'package:flutter/material.dart';

import '../controller/app_preferences.dart';
import 'color_enum.dart';

class ColorState with ChangeNotifier{

  Cores _backgroundColor = Cores.white;
  Cores _appBarColor = Cores.blue;
  Cores _cardColor = Cores.white;

  Cores get backgroundColor => _backgroundColor;
  Cores get appBarColor => _appBarColor;
  Cores get cardColor => _cardColor;

  Future<void> init() async {
    _backgroundColor = AppPreferences().getBackgroundColor();
    _appBarColor = AppPreferences().getAppBarColor();
    _cardColor = AppPreferences().getCardColor();
    notifyListeners();
  }

  void changeBackgroundColor(Cores backgroundColor)  {
    if(_backgroundColor != backgroundColor){
      _backgroundColor = backgroundColor;
      AppPreferences().changeBackgroundColor(backgroundColor);
      notifyListeners();
    }
  }

  void changeAppBarColor(Cores appBarColor)  {
    if(_appBarColor != appBarColor){
      _appBarColor = appBarColor;
      AppPreferences().changeAppBarColor(appBarColor);
      notifyListeners();
    }
  }

  void changeCardColor(Cores cardColor)  {
    if(_cardColor != cardColor){
      _cardColor = cardColor;
      AppPreferences().changeCardColor(cardColor);
      notifyListeners();
    }
  }
}