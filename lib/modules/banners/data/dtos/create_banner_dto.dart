import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';

class CreateBannerDto {
  String image;
  String link;

  CreateBannerDto({
    required this.image,
    required this.link,
  });

  factory CreateBannerDto.fromJson(Map<String, dynamic> json) {
    return CreateBannerDto(
      image: json['image'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'link': link,
    };
  }

  static CreateBannerDto empty() {
    return CreateBannerDto(
      image: '',
      link: '',
    );
  }

  static CreateBannerDto fromEntity(BannerEntity entity) {
    return CreateBannerDto(
      image: entity.image,
      link: entity.link,
    );
  }
}
