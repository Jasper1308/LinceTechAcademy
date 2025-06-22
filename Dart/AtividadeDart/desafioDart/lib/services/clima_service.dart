import 'package:desafioDart/models.dart';


// Soma todos as temperaturas e divide pelo tamanho da lista
double calcularMediaTemperatura(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else{
    double temperatura = 0;
    for(final medida in medidas){
      temperatura = temperatura + medida.tempC;
    }
    final media = temperatura / medidas.length;
    return media;
  }
}


// Retorna a maior temperatura
double calcularMaxTemperatura(List<MedidaClimatica>? medidas){
  double max = 0;
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else{
    for(final medida in medidas){
      if(medida.tempC > max){
        max = medida.tempC;
      }
    }
    return max;
  }
}


// Retorna a menor temperatura
double calcularMinTemperatura(List<MedidaClimatica>? medidas){
  double min = 30;
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else{
    for(final medida in medidas){
      if(medida.tempC < min){
        min = medida.tempC;
      }
    }
    return min;
  }
}

double calcularMediaUmidade(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else {
    double umidades = 0;
    for (final medida in medidas) {
      umidades = umidades + medida.umidade;
    }
    return umidades / medidas.length;
  }
}

double calcularMaxUmidade(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else {
    double max = 0;
    for(final medida in medidas){
      if(medida.umidade > max){
        max = medida.umidade;
      }
    }
    return max;
  }
}

double calcularMinUmidade(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else {
    double min = 1;
    for(final medida in medidas){
      if(medida.umidade < min){
        min = medida.umidade;
      }
    }
    return min;
  }
}

int direcaoFrequenteVento(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else {
    Map<int, int> ventos = {};
    for (final medida in medidas) {
      int direcao = medida.direcaoVento;
      ventos.update(direcao, (value) => value + 1, ifAbsent: () => 1);
    }
    int maiorFrequencia = 0;
    ventos.forEach((direcao, frequencia) {
      if (frequencia > maiorFrequencia) {
        maiorFrequencia = direcao;
      }
    });
    return maiorFrequencia;
  }
}

double calcularMediaVento(List<MedidaClimatica>? medidas){
  if(medidas == null || medidas.isEmpty){
    throw Exception("Lista Vazia");
  } else {
    double velocidade = 0;
    for (final medida in medidas) {
      velocidade = velocidade + medida.velVento;
    }
    return velocidade / medidas.length;
  }
}