class Genotype {
  final String _genotype;
  final List<String> _agglutinogens;
  final List<String> _agglutinins;
  String get genotype => _genotype;
  Genotype(String genotype)
      : _genotype = genotype,
        _agglutinogens = _getAgglutinogens(genotype),
        _agglutinins = _getAgglutinins(genotype) {
    if (!_isValidGenotype(genotype)) {
      throw Exception('Genotype invalid');
    }
  }

  String get bloodType {
    if (_genotype == 'AA' || _genotype == 'Ai') {
      return 'A';
    } else if (_genotype == 'BB' || _genotype == 'Bi') {
      return 'B';
    } else if (_genotype == 'AB') {
      return 'AB';
    } else {
      return 'O';
    }
  }

  List<String> get alleles {
    return _genotype.split('');
  }

  List<String> get agglutinogens {
    List<String> agglutinogensList = [];
    if (_genotype.contains('A') && _genotype.contains('B')) {
      agglutinogensList.add('A');
      agglutinogensList.add('B');
    } else if (_genotype.contains('A')) {
      agglutinogensList.add('A');
    } else if (_genotype.contains('B')) {
      agglutinogensList.add('B');
    } else {
      agglutinogensList.add('');
    }

    return agglutinogensList;
  }

  List<String> get agglutinins {
    List<String> agglutininsList = [];
    if (_genotype.contains('A') && _genotype.contains('B')) {
      agglutininsList.add('');
    } else if (_genotype.contains('A')) {
      agglutininsList.add('B');
    } else if (_genotype.contains('B')) {
      agglutininsList.add('A');
    } else if (_genotype.contains('i')) {
      agglutininsList.add('A');
      agglutininsList.add('B');
    }
    return agglutininsList;
  }

  List<String> offsprings(Genotype other) {
    List<String> possibleGenotypes = [];
    for (String allele1 in alleles) {
      for (String allele2 in other.alleles) {
        possibleGenotypes.add(allele1 + allele2);
      }
    }
    return possibleGenotypes.toSet().toList();
  }

  bool compatible(Genotype other) {
    return !(_agglutinogens
            .toSet()
            .intersection(other.agglutinins.toSet())
            .isEmpty ||
        _agglutinins.toSet().intersection(other.agglutinogens.toSet()).isEmpty);
  }

  static List<String> _getAgglutinogens(String genotype) {
    List<String> agglutinogens = [];
    if (genotype.contains('A')) {
      agglutinogens.add('A');
    }
    if (genotype.contains('B')) {
      agglutinogens.add('B');
    }
    return agglutinogens;
  }

  static List<String> _getAgglutinins(String genotype) {
    List<String> agglutinins = [];
    if (genotype.contains('i')) {
      agglutinins.add('A');
      agglutinins.add('B');
    }
    return agglutinins;
  }

  static bool _isValidGenotype(String genotype) {
    List<String> validGenotypes = ['AA', 'Ai', 'BB', 'Bi', 'AB', 'ii'];
    return validGenotypes.contains(genotype);
  }
}
