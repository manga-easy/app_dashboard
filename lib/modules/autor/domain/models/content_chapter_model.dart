class ContentChapterModel {
  int? id;
  int idChapter;
  String content;
  String type;
  String createat;
  String updateAt;
  ContentChapterModel({
    this.id,
    required this.idChapter,
    required this.content,
    required this.type,
    required this.createat,
    required this.updateAt,
  });
  ContentChapterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idChapter = json['id_chapter'],
        content = json['content'],
        type = json['type'],
        createat = json['createat'],
        updateAt = json['updateat'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['id_chapter'] = idChapter;
    data['content'] = content;
    data['type'] = type;
    data['createat'] = createat;
    data['updateat'] = updateAt;
    return data;
  }
}
