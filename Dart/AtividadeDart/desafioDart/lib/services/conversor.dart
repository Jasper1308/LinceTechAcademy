import 'dart:math';

// Funções de conversão de Temperatura
double paraFahrenheit(double temperatura){
  return (temperatura * 9/5)+32;
}

double paraKelvin(double temperatura){
  return temperatura + 273.15;
}

double paraRadianos(int graus){
  return graus * (pi / 180);
}

double paraMilhas(double vento){
  return vento / 1.609;
}

double paraMetros(double vento){
  return vento / 3.6;
}