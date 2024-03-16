import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';

class EmblemasRepositoryV1 implements EmblemasRepository {
  final ApiMonolito _apiMonolito;
  String get version => 'v1';
  String get feature => 'achievements';

  EmblemasRepositoryV1(
    this._apiMonolito,
  );

  @override
  Future<void> creatDocument({required Emblema objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: AchievementDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(endpoint: '$version/$feature/$id');
  }

  @override
  Future<Emblema?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/$id',
    );
    if (result.data.isEmpty) {
      return null;
    }

    return AchievementDto.fromMap(result.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required Emblema objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$feature/${objeto.id}',
      body: AchievementDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<Emblema>> listDocument({EmblemaParams? where}) async {
    final filtro = [];
    if (where != null) {
      if (where.categoria != null) {
        filtro.add('categoria=${where.categoria}&');
      }
    }
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/list?',
    );
    final data = result.data.map((e) => AchievementDto.fromMap(e)).toList();
    return data.map((e) => e.toEntity()).toList();
  }
}
