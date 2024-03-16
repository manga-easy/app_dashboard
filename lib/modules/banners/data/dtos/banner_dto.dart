import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_model.dart';

class BannerDto {
  final String? id;
  final String image;
  final String link;
  final int createdat;
  final int updatedat;

  BannerDto({
    this.id,
    required this.image,
    required this.link,
    required this.createdat,
    required this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': id,
      'image': image,
      'link': link,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory BannerDto.fromMap(Map<String, dynamic> map) {
    return BannerDto(
      id: map['uid'],
      image: map['image'],
      link: map['link'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }

  factory BannerDto.fromEntity(BannerModel bannerModel) {
    return BannerDto(
      id: bannerModel.id,
      image: bannerModel.image,
      link: bannerModel.link,
      createdat: bannerModel.createdat,
      updatedat: bannerModel.updatedat,
    );
  }

  BannerModel toEntity() {
    return BannerModel(
      id: id,
      image: image,
      link: link,
      createdat: createdat,
      updatedat: updatedat,
    );
  }
}
