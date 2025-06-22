import 'dart:io';

Future<void> converterTodosMp4ParaMp3(String pastaEntrada, String pastaSaida) async {
  final dirEntrada = Directory(pastaEntrada);
  final dirSaida = Directory(pastaSaida);

  if (!await dirEntrada.exists()) {
    print('Pasta de entrada não existe.');
    return;
  }

  if (!await dirSaida.exists()) {
    await dirSaida.create(recursive: true);
  }

  final arquivos = dirEntrada
      .listSync()
      .where((f) => f is File && f.path.toLowerCase().endsWith('.mp4'))
      .cast<File>();

  if (arquivos.isEmpty) {
    print('Nenhum arquivo .mp4 encontrado na pasta.');
    return;
  }

  for (final arquivo in arquivos) {
    final nomeBase = arquivo.uri.pathSegments.last.replaceAll('.mp4', '');
    final caminhoMp3 = '${dirSaida.path}/$nomeBase.mp3';

    print('Convertendo ${arquivo.path} → $caminhoMp3');

    final resultado = await Process.run(
      'C:/ffmpeg/ffmpeg-7.1.1-essentials_build/bin/ffmpeg.exe',
      ['-i', arquivo.path, '-q:a', '0', '-map', 'a', caminhoMp3],
      runInShell: true,
    );

    if (resultado.exitCode == 0) {
      print('✔️  Sucesso: $nomeBase.mp3');
    } else {
      print('❌  Erro ao converter ${arquivo.path}');
      print(resultado.stderr);
    }
  }
}

void main() async {
  const pastaEntrada = 'C:/mp4maico';
  const pastaSaida = 'C:/mp4maico/mp3';

  await converterTodosMp4ParaMp3(pastaEntrada, pastaSaida);
}
