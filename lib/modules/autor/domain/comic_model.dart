class ComicModel {
  int? id;
  String title;
  String uniqueid;
  String sinopse;
  String autor;
  int yearUp;
  String scans;
  bool status;
  String cover;
  List<Chapter> chapter;

  ComicModel({
    this.id,
    required this.title,
    required this.uniqueid,
    required this.sinopse,
    required this.autor,
    required this.yearUp,
    required this.scans,
    required this.status,
    required this.cover,
    required this.chapter,
  });

  ComicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        uniqueid = json['uniqueid'],
        sinopse = json['sinopse'],
        autor = json['autor'],
        yearUp = json['year_up'],
        scans = json['scans'],
        status = json['status'],
        cover = json['cover'],
        chapter = json['chapter'].map((v) => Chapter.fromJson(v));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['uniqueid'] = uniqueid;
    data['sinopse'] = sinopse;
    data['autor'] = autor;
    data['year_up'] = yearUp;
    data['scans'] = scans;
    data['status'] = status;
    data['cover'] = cover;
    data['chapter'] = chapter.map((v) => v.toJson()).toList();
    return data;
  }
}

class Chapter {
  int? id;
  int idComic;
  String title;
  double number;
  String dateUp;

  Chapter({
    this.id,
    required this.idComic,
    required this.title,
    required this.number,
    required this.dateUp,
  });

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idComic = json['id_comic'],
        title = json['title'],
        number = json['number'],
        dateUp = json['date_up'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['id_comic'] = idComic;
    data['title'] = title;
    data['number'] = number;
    data['date_up'] = dateUp;
    return data;
  }
}