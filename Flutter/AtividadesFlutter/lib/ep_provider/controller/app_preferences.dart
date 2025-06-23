import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_enum.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  factory AppPreferences() => _instance;
  AppPreferences._internal();

  late SharedPreferences _prefs;

  static const String backgroundColorKey = 'backgroundColor';
  static const String appBarColorKey = 'appBarColor';
  static const String cardColorKey = 'cardColor';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> changeBackgroundColor(Cores backgroundColor) async {
      await _prefs.setInt(backgroundColorKey, backgroundColor.index);
  }

  Future<void> changeAppBarColor(Cores appBarColor) async {
    await _prefs.setInt(appBarColorKey, appBarColor.index);
  }

  Future<void> changeCardColor(Cores cardColor) async {
    await _prefs.setInt(cardColorKey, cardColor.index);
  }

  Cores getBackgroundColor() {
    return Cores.values[_prefs.getInt(backgroundColorKey) ?? Cores.white.index];
  }

  Cores getAppBarColor() {
    return Cores.values[_prefs.getInt(appBarColorKey) ?? Cores.blue.index];
  }

  Cores getCardColor() {
    return Cores.values[_prefs.getInt(cardColorKey) ?? Cores.white.index];
  }

}