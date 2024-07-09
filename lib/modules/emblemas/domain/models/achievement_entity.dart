import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_category.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_rarity.dart';

class AchievementEntity {
  final String id;
  final String name;
  final AchievementRarity rarity;
  final String description;
  final double percentRarity;
  final int totalAcquired;
  final String url;
  final String benefits;
  final bool reclaim;
  final AchievementCategory category;
  final int createdAt;
  final int updatedAt;

  AchievementEntity({
    required this.id,
    required this.name,
    required this.rarity,
    required this.description,
    required this.percentRarity,
    required this.totalAcquired,
    required this.url,
    required this.benefits,
    required this.reclaim,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AchievementEntity.fromJson(Map<String, dynamic> json) {
    return AchievementEntity(
      id: json['id'],
      name: json['name'],
      rarity: AchievementRarity.byName(json['rarity']),
      description: json['description'],
      percentRarity: json['percentRarity'],
      totalAcquired: json['totalAcquired'],
      url: json['url'],
      benefits: json['benefits'],
      reclaim: json['reclaim'],
      category: AchievementCategory.byName(json['category']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
