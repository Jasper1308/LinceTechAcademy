import 'dart:io';
import 'package:desafioDart/services/file_servicec.dart';
import 'package:desafioDart/models.dart';
import 'package:desafioDart/ui/relatorio_view.dart';
import 'package:desafioDart/ui/menu.dart';

void main() async{
  // Lê todos os arquivos do diretório
  final arquivos = Directory(r'C:\clima\sensores').listSync();
  // Lista para adicionar todos arquivos CSV como String
  List<String> listaArquivos = await paraString(arquivos);
  // Lista para armazenar os dados como objetos MedidaClimatica
  Map<String, List<MedidaClimatica>> dados = await preencherMapa(listaArquivos, arquivos);
  while(dados != 0){
    exibirMenu();
    int opcao = obterOpcao();
    switch(opcao){
      case 1: exibirRelatorioTemperatura(dados);
      break;
      case 2: exibirRelatorioUmidade(dados);
      break;
      case 3: exibirRelatorioVento(dados);
    }
  }
}