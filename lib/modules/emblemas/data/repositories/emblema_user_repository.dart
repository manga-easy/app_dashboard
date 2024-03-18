import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/achievements_user_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';

class EmblemaUserRepositoryV1 implements EmblemaUserRepository {
  final ApiMonolito _apiMonolito;
  String get version => 'v1';

  EmblemaUserRepositoryV1(
    this._apiMonolito,
  );

  @override
  Future<void> creatDocument({required EmblemaUser objeto}) async {
    final String userID = objeto.userId;
    await _apiMonolito.post(
      endpoint: '$version/users/$userID/achievements',
      body: AchievementsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({
    required String idEmblema,
    required String userID,
  }) async {
    await _apiMonolito.delete(
      endpoint: '$version/users/$userID/achievements/$idEmblema',
    );
  }

  @override
  Future<EmblemaUser?> getDocument({
    required String idEmblema,
    required String userID,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDocument({required EmblemaUser objeto}) async {
    final String userID = objeto.userId;
    await _apiMonolito.put(
      endpoint: '$version/users/$userID/achievements/${objeto.id}',
      body: AchievementsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<EmblemaUser>> listDocument({
    required EmblemaUserParams where,
  }) async {
    String filter = '';
    if (where.idEmblema != null) {
      filter += 'idemblema=${where.idEmblema}&';
    }
    final result = await _apiMonolito.get(
      endpoint: '$version/users/${where.userId}/achievements?$filter',
    );
    return result.data
        .map((e) => AchievementsUserDto.fromMap(e).toEntity())
        .toList();
  }
}
