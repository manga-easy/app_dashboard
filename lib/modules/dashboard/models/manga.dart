class Manga {
  String? id;
  String title;
  String href;
  String capa;

  Manga.fromValue({
    required this.capa,
    required this.href,
    required this.title,
  });

  Manga.fromJson(dynamic json)
      : id = json['\$id'],
        title = json['title'],
        href = json['href'],
        capa = json['capa'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['\$id'] = this.id;
    data['title'] = this.title;
    data['href'] = this.href;
    data['capa'] = this.capa;
    return data;
  }
}
