class InfoComicModel {
  String? id;
  String name;
  String uniqueid;
  String lastcap;
  int totalViews;
  String author;
  String thumb;
  String synopsis;
  double ratio;
  String scans;
  int updatedAt;
  int createdAt;
  String genres;
  int year;

  InfoComicModel({
    this.id,
    required this.name,
    required this.uniqueid,
    required this.lastcap,
    required this.totalViews,
    required this.author,
    required this.thumb,
    required this.synopsis,
    required this.ratio,
    required this.scans,
    required this.updatedAt,
    required this.createdAt,
    required this.genres,
    required this.year,
  });
}
