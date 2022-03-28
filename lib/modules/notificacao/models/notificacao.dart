class Notificacao {
  static String get collectionId => '6231187cc9c3b9ec371a';
  String? id;
  String titulo;
  String menssege;
  String? idHost;
  Notificacao({
    this.id,
    required this.menssege,
    required this.titulo,
    this.idHost,
  });
  Notificacao.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        menssege = json['menssege'],
        idHost = json['idHost'],
        id = json['\$id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['\$id'] = id;
    data['titulo'] = titulo;
    data['idHost'] = idHost;
    data['menssege'] = menssege;
    return data;
  }
}
