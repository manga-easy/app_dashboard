class Recomendacao {
  static String get collectionId => '623d0f7c9df076d1ef89';
  String id;
  List<String> generos;

  Recomendacao({
    required this.id,
    required this.generos,
  });

  Recomendacao.fromJson(dynamic json)
      : id = json['\$id'],
        generos = json['generos'].map<String>((e) => e.toString()).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['\$id'] = id;
    data['generos'] = generos;
    return data;
  }
}
