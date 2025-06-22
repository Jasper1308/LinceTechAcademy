import 'dart:math';

void main() {
  final pessoa = Pessoa();
  // Lista de fornecedores recebe um objeto que implementa a interface Fornecedor
  final fornecedor = <Fornecedor>[
    FornecedorDeBebidas(),
    FornecedorDeSanduiches(),
    FornecedorDeBolos(),
    FornecedorDeSaladas(),
    FornecedorDePetiscos(),
    FornecedorDeUltraCaloricos(),
  ];

  // Consumindo produtos fornecidos
  for (var i = 0; i < 5; i++) {
    pessoa.refeicao(fornecedor);
  }

  pessoa.informacoes();
}

class Produto {
  Produto(this.nome, this.calorias);

  /// Nome deste produto
  final String nome;

  /// Total de calorias
  final int calorias;
}

// implementando interface Fornecedor
class FornecedorDeBebidas implements Fornecedor{
  final _random = Random();
  final _bebidasDisponiveis = <Produto>[
    Produto('Agua', 0),
    Produto('Refrigerante', 200),
    Produto('Suco de fruta', 100),
    Produto('Energetico', 135),
    Produto('Cafe', 60),
    Produto('Cha', 35),
  ];
  /// Retorna um produto que pode ser consumido por um consumidor
  @override
  Produto fornecer() {
    return _bebidasDisponiveis[_random.nextInt(_bebidasDisponiveis.length)];
  }
}

// Criado Fornecedores restantes
class FornecedorDeSanduiches implements Fornecedor {
  final _random = Random();
  final _sanduichesDisponiveis = <Produto>[
    Produto('Pao com queijo', 100),
    Produto('Pao com linguiça blumenau', 160),
    Produto('Misto quente', 200),
    Produto('Sanduiche de salame', 300),
    Produto('Pao com presunto, queijo, ovo e bacon', 400),
  ];
  @override
  Produto fornecer() {
    return _sanduichesDisponiveis[_random.nextInt(_sanduichesDisponiveis.length)];
  }
}

class FornecedorDeBolos implements Fornecedor {
  final _random = Random();
  final _bolosDisponiveis = <Produto>[
    Produto('Bolo de chocolate', 300),
    Produto('Bolo de morango', 150),
    Produto('Bolo de banana', 250),
    Produto('Mousse de morango', 450),
    Produto('Torta de maça', 550),
    Produto('Banoffe', 400),
  ];
  @override
  Produto fornecer() {
    return _bolosDisponiveis[_random.nextInt(_bolosDisponiveis.length)];
  }
}

class FornecedorDeSaladas implements Fornecedor {
  final _random = Random();
  final _saladasDisponiveis = <Produto>[
    Produto('Salada de alface', 0),
    Produto('Salada de tomate', 50),
    Produto('Salada de pepino', 100),
    Produto('Salada de cenoura', 150),
  ];
  @override
  Produto fornecer() {
    return _saladasDisponiveis[_random.nextInt(_saladasDisponiveis.length)];
  }
}

class FornecedorDePetiscos implements Fornecedor {
  final _random = Random();
  final _petiscosDisponiveis = <Produto>[
    Produto('Coxinha', 200),
    Produto('Pastel', 150),
    Produto('Empada', 100),
  ];
  @override
  Produto fornecer() {
    return _petiscosDisponiveis[_random.nextInt(_petiscosDisponiveis.length)];
  }
}

class FornecedorDeUltraCaloricos implements Fornecedor {
  final _random = Random();
  final _ultraCaloricosDisponiveis = <Produto>[
    Produto('Hamburguer', 400),
    Produto('Pizza', 600),
    Produto('Sushi', 550),
    Produto('Hot dog', 420),
  ];
  @override
  Produto fornecer() {
    return _ultraCaloricosDisponiveis[_random.nextInt(_ultraCaloricosDisponiveis.length)];
  }
}

enum nivelDeCalorias {
  deficitExtremo,
  deficit,
  satisfeito,
  excesso,
}

extension nivelDeCaloriasExt on nivelDeCalorias {
  String get nome {
    switch (this) {
      case nivelDeCalorias.deficitExtremo:
        return 'deficit extremo';
      case nivelDeCalorias.deficit:
        return 'deficit';
      case nivelDeCalorias.satisfeito:
        return 'satisfeito';
      case nivelDeCalorias.excesso:
        return 'excesso';
    }
  }
}

class Pessoa {
  // Acumulador de calorias
  int _caloriasConsumidas = 0;
  // Nivel de calorias
  nivelDeCalorias _nivelDeCalorias = nivelDeCalorias.satisfeito;

  // Construtor que recebe calorias iniciais
  Pessoa() : _caloriasConsumidas = Random().nextInt(1500);

  /// Imprime as informacoes desse consumidor
  void informacoes() {
    print('Calorias consumidas: $_caloriasConsumidas kcal');
    print('Nivel de calorias: ${_nivelDeCalorias.nome}');
  }

  /// Recebe uma lista de objetos que implementam a interface Fornecedor e escolhe um para consumir
  void refeicao(List<Fornecedor> fornecedores) {
    final _random = Random();
    final fornecedor = fornecedores[_random.nextInt(fornecedores.length)];
    final produto = fornecedor.fornecer();
    print('Consumindo ${produto.nome} (${produto.calorias} calorias)');
    _caloriasConsumidas += produto.calorias;
    verificarNivelDeCalorias();
  }

  // funcao para verificar nivel de calorias
  void verificarNivelDeCalorias() {
    if (_caloriasConsumidas < 500) {
      _nivelDeCalorias = nivelDeCalorias.deficitExtremo;
    } else if (_caloriasConsumidas < 1800) {
      _nivelDeCalorias = nivelDeCalorias.deficit;
    } else if (_caloriasConsumidas < 2500) {
      _nivelDeCalorias = nivelDeCalorias.satisfeito;
    } else {
      _nivelDeCalorias = nivelDeCalorias.excesso;
    }
  }
}

abstract class Fornecedor {
  Produto fornecer();
}