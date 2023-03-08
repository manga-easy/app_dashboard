class MangaFilterEntity {
  String? search;
  int? yearAt;
  int? yearFrom;
  List<String> genders;
  double? rating;
  String? author;
  String? uniqueid;

  MangaFilterEntity(
      {this.search,
      this.yearAt,
      this.yearFrom,
      required this.genders,
      this.rating,
      this.author,
      this.uniqueid});
}
