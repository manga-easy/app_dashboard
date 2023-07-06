import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/achievements_user_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EmblemaUserRepositoryV1 implements EmblemaUserRepository {
  final ApiMonolito _apiMonolito;
  String get version => 'v1';

  EmblemaUserRepositoryV1(
    this._apiMonolito,
  );

  @override
  Future<void> creatDocument({required EmblemaUser objeto}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.post(
      endpoint: '$version/users/$userID/achievements',
      body: AchievementsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.delete(
      endpoint: '$version/users/$userID/achievements/$id',
    );
  }

  @override
  Future<EmblemaUser?> getDocument({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateDocument({required EmblemaUser objeto}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.post(
      endpoint: '$version/users/$userID/achievements/${objeto.id}',
      body: AchievementsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<EmblemaUser>> listDocument({EmblemaUserParams? where}) async {
    throw UnimplementedError();
  }
}
