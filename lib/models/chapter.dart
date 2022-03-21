import 'package:dashboard_manga_easy/models/imageChapters.dart';

class Chapter {
  String? id;
  String title;
  String href;
  String date;
  List<ImageChapter> imagens;

  Chapter({
    required this.title,
    required this.href,
    required this.id,
    required this.imagens,
    required this.date,
  });

  Chapter.fromJson(dynamic json)
      : id = json['id'],
        title = json['title'],
        date = json['date'] ?? "",
        imagens = json['imagens'] != null
            ? json['imagens'].map<ImageChapter>((e) => ImageChapter.fromJson(e)).toList()
            : [],
        href = json['href'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['date'] = date;
    data['title'] = title;
    data['href'] = href;
    data['imagens'] = this.imagens.map((v) => v.toJson()).toList();
    return data;
  }
}
