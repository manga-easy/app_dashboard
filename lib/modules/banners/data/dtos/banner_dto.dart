import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class BannerDto {
  final String? id;
  final String type;
  final String image;
  final String link;
  final int createdat;
  final int updatedat;

  BannerDto({
    this.id,
    required this.type,
    required this.image,
    required this.link,
    required this.createdat,
    required this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'image': image,
      'link': link,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory BannerDto.fromMap(Map<String, dynamic> map) {
    return BannerDto(
      id: map['id'] != null ? map['id'] as String : null,
      type: map['type'] as String,
      image: map['image'] as String,
      link: map['link'] as String,
      createdat: map['createdat'] as int,
      updatedat: map['updatedat'] as int,
    );
  }

  factory BannerDto.fromEntity(BannerModel bannerModel) {
    return BannerDto(
      id: bannerModel.id,
      type: bannerModel.type,
      image: bannerModel.image,
      link: bannerModel.link,
      createdat: bannerModel.createdat,
      updatedat: bannerModel.updatedat,
    );
  }

  BannerModel toEntity() {
    return BannerModel(
      id: id,
      type: type,
      image: image,
      link: link,
      createdat: createdat,
      updatedat: updatedat,
    );
  }
}
