import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/users/data/dtos/create_user_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user_achievement_entity.dart';

class UserAchievementRepository {
  final ApiMonolith _apiMonolito;

  UserAchievementRepository(
    this._apiMonolito,
  );

  Future<UserAchievement> creatDocument({
    required CreateUserAchievementDto objeto,
  }) async {
    final String userId = objeto.userId;
    final result = await _apiMonolito.post(
      'users/$userId/v1/achievements',
      body: objeto.toJson(),
    );

    return UserAchievement.fromJson(result);
  }

  Future<void> deletDocument({
    required String achievementId,
    required String userId,
  }) async {
    await _apiMonolito.delete(
      'users/$userId/v1/achievements/$achievementId',
    );
  }

  Future<List<UserAchievement>> listDocument({
    String? achievementId,
    required String userId,
  }) async {
    String filter = '';
    if (achievementId != null) {
      filter += 'achievementId=$achievementId&';
    }
    final result = await _apiMonolito.get(
      'users/$userId/v1/achievements?$filter',
    );
    if (result == null) {
      return [];
    }
    if (result.isEmpty) {
      return [];
    }
    return result
        .map<UserAchievement>((e) => UserAchievement.fromJson(e))
        .toList();
  }
}
