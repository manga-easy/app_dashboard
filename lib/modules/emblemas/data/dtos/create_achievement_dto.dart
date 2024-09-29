import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_category.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_rarity.dart';

class CreateAchievementDto {
  String name;
  String rarity;
  String description;
  String url;
  List<String> benefits;
  bool reclaim;
  String category;

  CreateAchievementDto({
    required this.name,
    required this.rarity,
    required this.description,
    required this.url,
    required this.benefits,
    required this.reclaim,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rarity': rarity,
      'description': description,
      'url': url,
      'benefits': benefits.join(','),
      'reclaim': reclaim,
      'category': category,
    };
  }

  static CreateAchievementDto empty() {
    return CreateAchievementDto(
      name: '',
      rarity: AchievementRarity.comum.name,
      description: '',
      url: '',
      benefits: [],
      reclaim: false,
      category: AchievementCategory.evento.name,
    );
  }

  static CreateAchievementDto fromEntity(AchievementEntity entity) {
    return CreateAchievementDto(
      name: entity.name,
      rarity: entity.rarity.name,
      description: entity.description,
      url: entity.url,
      benefits: entity.benefits.split(','),
      reclaim: entity.reclaim,
      category: entity.category.name,
    );
  }
}
