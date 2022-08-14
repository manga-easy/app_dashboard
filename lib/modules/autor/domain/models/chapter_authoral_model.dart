class ChapterAuthorial {
  int? id;
  int idComicAuthorial;
  String title;
  double number;
  String createAt;
  String updateAt;

  ChapterAuthorial({
    this.id,
    required this.idComicAuthorial,
    required this.title,
    required this.number,
    required this.createAt,
    required this.updateAt,
  });

  ChapterAuthorial.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idComicAuthorial = json['id_comic'],
        title = json['title'],
        number = json['number'],
        createAt = json['createat'],
        updateAt = json['updateat'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['id_comic'] = idComicAuthorial;
    data['title'] = title;
    data['number'] = number;
    data['createat'] = createAt;
    data['updateat'] = updateAt;
    return data;
  }
}
