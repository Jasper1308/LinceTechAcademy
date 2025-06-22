import 'dart:io';
import 'dart:convert';
import 'package:desafioDart/models.dart';

// Lê o conteúdo de cada arquivo com codificação Latin1 e adiciona à lista como String
Future<List<String>> paraString(List<FileSystemEntity> arquivos) async{
  List<String> listaArquivos = [];
  for (final arquivo in arquivos) {
    try {
      // Uso de API de gerenciamento de arquivos para ler e converter o conteúdo
      listaArquivos.add(await File(arquivo.path).openRead().transform(latin1.decoder).join());
    } catch (e) {
      throw Exception("Erro ao ler arquivo ${arquivo.path}");
    }
  }
  return listaArquivos;
}

// Lê o conteúdo como String e retorna uma Lista de objetos
List<MedidaClimatica> construirObjetos(String arquivo){
  // Separa os arquivos em linhas
  List<String> linhas = arquivo.split("\n");
  // Lista de objetos da classe MedidaClimatica
  List<MedidaClimatica> medidas = [];
  // Percorre cada linha pulando a primeira (cabeçalho)
  for(int i = 1; i < linhas.length; i++){
    // Separa cada item da linha separado por virgula
    List<String> conteudo = linhas[i].split(",");
    // Constroí objeto convertendo tipos de dados e adiciona a lista, caso de erro ignora
    try {
      medidas.add(MedidaClimatica(
          mes: int.parse(conteudo[0]),
          dia: int.parse(conteudo[1]),
          hora: int.parse(conteudo[2]),
          tempC: double.parse(conteudo[3]),
          umidade: double.parse(conteudo[4]),
          densidade: double.parse(conteudo[5]),
          velVento: int.parse(conteudo[6]),
          direcaoVento: int.parse(conteudo[7])));
    } catch (e) {
      continue;
    }

  }
  return medidas;
}

// Gera chave a partir do titulo do arquivo
String gerarChave(String path){
  final nome = path.split(r"\").last.replaceAll(".csv", "");
  final partes = nome.split("_");
  final chave = partes[0] + partes[2];
  return chave;
}

// Função que preenche mapa
Future<Map<String, List<MedidaClimatica>>> preencherMapa(List<String> arquivosString, List<FileSystemEntity> arquivos) async {
  Map<String, List<MedidaClimatica>> dados = {};
  for(int i = 0; i < arquivosString.length; i++){
    List<MedidaClimatica> objeto = construirObjetos(arquivosString[i]);
    dados[gerarChave(arquivos[i].path)] = objeto;
  }
  return dados;
}