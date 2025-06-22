import 'package:flutter/material.dart';

enum Cores{
  blue,
  red,
  grey,
  yellow,
  white
}

extension CoresExtension on Cores{
  String get displayString {
    switch(this){
      case Cores.blue: return 'Azul';
      case Cores.red: return 'Vermelho';
      case Cores.grey: return 'Cinza';
      case Cores.yellow: return 'Amarelo';
      case Cores.white: return 'Branco';
    }
  }

  Color get color{
    switch(this){
      case Cores.blue: return Colors.blue;
      case Cores.red: return Colors.red;
      case Cores.grey: return Colors.grey;
      case Cores.yellow: return Colors.yellow;
      case Cores.white: return Colors.white;
    }
  }
}