// Criado classe medida climatica para armazenar cada linha dos arquivos.
class MedidaClimatica {
  final int mes;
  final int dia;
  final int hora;
  final double tempC;
  final double umidade;
  final double densidade;
  final int velVento;
  final int direcaoVento;

  // Construtor da classe
  MedidaClimatica({
    required this.mes,
    required this.dia,
    required this.hora,
    required this.tempC,
    required this.umidade,
    required this.densidade,
    required this.velVento,
    required this.direcaoVento,
  });
}