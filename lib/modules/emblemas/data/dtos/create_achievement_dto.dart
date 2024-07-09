import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';

class CreateAchievementDto {
  String name;
  String rarity;
  String description;
  String url;
  String _benefits;
  bool reclaim;
  String category;

  CreateAchievementDto({
    required this.name,
    required this.rarity,
    required this.description,
    required this.url,
    required String benefits,
    required this.reclaim,
    required this.category,
  }) : _benefits = benefits;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rarity': rarity,
      'description': description,
      'url': url,
      'benefits': benefits,
      'reclaim': reclaim,
      'category': category,
    };
  }

  static CreateAchievementDto empty() {
    return CreateAchievementDto(
      name: '',
      rarity: '',
      description: '',
      url: '',
      benefits: '',
      reclaim: false,
      category: '',
    );
  }

  static CreateAchievementDto fromEntity(AchievementEntity entity) {
    return CreateAchievementDto(
      name: entity.name,
      rarity: entity.rarity.name,
      description: entity.description,
      url: entity.url,
      benefits: entity.benefits,
      reclaim: entity.reclaim,
      category: entity.category.name,
    );
  }

  List<String> get benefits => _benefits.split(',');
  set benefits(List<String> benefits) {
    _benefits = benefits.join(',');
  }
}
