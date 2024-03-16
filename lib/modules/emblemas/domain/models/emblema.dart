enum TypeEmblema { asset, svg, link }

enum CategoriaEmblema { evento, doacao, rank }

enum RarityEmblema {
  comum(label: 'Comum'),
  incomum(label: 'Incomum'),
  raro(label: 'Raro'),
  mitico(label: 'Mítico'),
  lendario(label: 'Lendário'),
  unico(label: 'Único');

  const RarityEmblema({required this.label});

  final String label;
}

class Emblema {
  String? id;
  String name;
  RarityEmblema rarity;
  String description;
  double percent;
  String url;
  List<String> benefits;
  bool adsOff;
  bool disponivel;
  String categoria;
  String type;
  int createAt;
  int updateAt;

  Emblema({
    this.id,
    required this.name,
    required this.rarity,
    required this.description,
    required this.percent,
    required this.url,
    required this.benefits,
    required this.adsOff,
    required this.disponivel,
    required this.type,
    required this.categoria,
    required this.createAt,
    required this.updateAt,
  });

  static RarityEmblema validaRarity(String rarity) {
    var index = RarityEmblema.values.indexWhere(
      (element) => element.name == rarity,
    );
    if (index == -1) {
      index = RarityEmblema.values.indexWhere(
        (element) => element.label == rarity,
      );
    }
    return RarityEmblema.values[index];
  }

  Emblema.empty()
      : name = '',
        createAt = DateTime.now().millisecondsSinceEpoch,
        updateAt = DateTime.now().millisecondsSinceEpoch,
        rarity = RarityEmblema.comum,
        description = '',
        percent = 0.1,
        url = '',
        benefits = [],
        adsOff = false,
        disponivel = false,
        type = TypeEmblema.link.name,
        categoria = CategoriaEmblema.evento.name;
}
