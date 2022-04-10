class ImageChapter {
  String? id;
  String src;
  String? path;

  ImageChapter({required this.src});

  ImageChapter.fromJson(dynamic json)
      : id = json['id'],
        path = json['path'],
        src = json['src'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['path'] = path;
    return data;
  }
}
