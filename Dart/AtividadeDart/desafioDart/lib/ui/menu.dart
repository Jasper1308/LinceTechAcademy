import 'dart:io';

void exibirMenu(){
  print("Olá, Marcelo. Que relatório precisa?");
  print("1 - Temperatura");
  print("2 - Umidade");
  print("3 - Direção do vento");
  print("Digite o número da opção desejada: ");
}

int obterOpcao(){
  int? opcao;
  while (opcao == null || opcao > 3 || opcao < 1){
    exibirMenu();
    String? input = stdin.readLineSync();
    if (input != null){
      try {
        opcao = int.parse(input);
        if(opcao < 1 || opcao > 3){
          print("Escolha um número entre 1 e 3. ");
        }
      } catch (e) {
        print("Entrada inválida. ");
      }
    } else {
      print("Entrada inválida. ");
    }
  }
  return opcao;
}