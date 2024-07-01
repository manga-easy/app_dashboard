class BannerEntity {
  final String id;
  final String image;
  final String link;
  final int createdAt;
  final int updatedAt;

  BannerEntity({
    required this.id,
    required this.image,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerEntity.fromJson(Map<String, dynamic> json) {
    return BannerEntity(
      id: json['id'],
      image: json['image'],
      link: json['link'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static BannerEntity empty() {
    return BannerEntity(
      id: '',
      image: '',
      link: '',
      createdAt: 0,
      updatedAt: 0,
    );
  }
}
