class Recomendacao {
  static String get collectionId => '623d0f7c9df076d1ef89';
  String id;
  List<String> generos;
  String link;
  String nomeManga;
  String uniqueid;

  Recomendacao({
    required this.id,
    required this.generos,
    required this.link,
    required this.nomeManga,
    required this.uniqueid,
  });

  Recomendacao.fromJson(dynamic json)
      : id = json['\$id'],
        generos = json['generos'].map<String>((e) => e.toString()).toList(),
        link = json['link'],
        nomeManga = json['nomeManga'],
        uniqueid = json['uniqueid'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['\$id'] = id;
    data['generos'] = generos;
    data['link'] = link;
    data['nomeManga'] = nomeManga;
    data['uniqueid'] = uniqueid;
    return data;
  }
}
