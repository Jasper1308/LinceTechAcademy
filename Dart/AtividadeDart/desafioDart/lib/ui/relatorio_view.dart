import 'package:yaansi/yaansi.dart';
import 'package:desafioDart/models.dart';
import 'package:desafioDart/services/conversor.dart';
import 'package:desafioDart/services/clima_service.dart';

void exibirRelatorioTemperatura(Map<String, List<MedidaClimatica>> dados){
  print("RELATORIO TEMPERATURA!");

  dados.forEach((chave, medidas){
    String estado = chave[0] + chave[1];
    String mes = chave.substring(2, chave.length);

    double temperaturaMedia = calcularMediaTemperatura(medidas);
    double temperaturaMin = calcularMinTemperatura(medidas);
    double temperaturaMax = calcularMaxTemperatura(medidas);

    print("Estado: $estado Mes: $mes");
    print("Temperatura Media: ${temperaturaMedia.toStringAsFixed(2).red} °C,"
        " ${paraFahrenheit(temperaturaMedia).toStringAsFixed(2).yellow} °F,"
        " ${paraKelvin(temperaturaMedia).toStringAsFixed(2).blue} °K.");
    print("Temperatura Mínima: ${temperaturaMin.toStringAsFixed(2).red} °C,"
        " ${paraFahrenheit(temperaturaMin).toStringAsFixed(2).yellow} °F,"
        " ${paraKelvin(temperaturaMin).toStringAsFixed(2).blue} °K.");
    print("Temperatura Máxima: ${temperaturaMax.toStringAsFixed(2).red} °C,"
        " ${paraFahrenheit(temperaturaMax).toStringAsFixed(2).yellow} °F,"
        " ${paraKelvin(temperaturaMax).toStringAsFixed(2).blue} °K.");
  });
}

void exibirRelatorioUmidade(Map<String, List<MedidaClimatica>> dados){
  print("RELATORIO UMIDADE!");

  dados.forEach((chave, medidas){
    String estado = chave[0] + chave[1];
    String mes = chave.substring(2, chave.length);

    double umidadeMedia = calcularMediaUmidade(medidas);
    double umidadeMin = calcularMinUmidade(medidas);
    double umidadeMax = calcularMaxUmidade(medidas);

    print("Estado: $estado Mes: $mes");
    print("Umidade Media: ${umidadeMedia.toStringAsFixed(3).green}");
    print("Umidade Mínima: ${umidadeMin.toStringAsFixed(3).blue}");
    print("Umidade Máxima: ${umidadeMax.toStringAsFixed(3).red}");
  });
}

void exibirRelatorioVento(Map<String, List<MedidaClimatica>> dados){
  print("RELATORIO VENTO!");

  dados.forEach((chave, medidas){
    String estado = chave[0] + chave[1];
    String mes = chave.substring(2, chave.length);

    int vento = direcaoFrequenteVento(medidas);

    print("Estado: $estado Mes: $mes");
    print("Direção em Graus: ${vento.toString().yellow},");
    print("Direção em Radianos ${paraRadianos(vento).toStringAsFixed(3).yellow}");
    print("Velocidade Media: ${calcularMediaVento(medidas).toStringAsFixed(2).blue} Km/H, "
        "${paraMilhas(calcularMediaVento(medidas)).toStringAsFixed(2).blue} MPH, "
        "${paraMetros(calcularMediaVento(medidas)).toStringAsFixed(2).blue} M/S.");
  });
}