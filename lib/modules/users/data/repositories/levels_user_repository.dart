import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/users/data/dtos/levels_user_dto.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/levels_user_filter.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/levels_user_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class LevelsUserRepositoryV1 implements LevelsUserRepository {
  final ApiMonolito _apiMonolito;

  LevelsUserRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'levels';

  @override
  Future<void> creatDocument({required NivelUser objeto}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.post(
      endpoint: '$version/users/$userID/$feature',
      body: LevelsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.delete(endpoint: '$version/users/$userID/$feature/$id');
  }

  @override
  Future<NivelUser?> getDocument({required String id}) async {
    final String userID = ServiceRoute.user!.id!;
    final ret = await _apiMonolito.get(
      endpoint: '$version/users/$userID/$feature/$id',
    );
    if (ret.data.isEmpty) {
      return null;
    }
    return LevelsUserDto.fromMap(ret.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required NivelUser objeto}) async {
    final String userID = ServiceRoute.user!.id!;
    await _apiMonolito.put(
      endpoint: '$version/users/$userID/$feature/${objeto.id}',
      body: LevelsUserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<NivelUser>> listDocument({
    required LevelsUserFilter where,
  }) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/users/${where.userId}/$feature',
    );
    return result.data.map((e) => LevelsUserDto.fromMap(e).toEntity()).toList();
  }
}
