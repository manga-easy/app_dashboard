import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/temporadas/data/dtos/seasons_dto.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/models/temporadas_params.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class SeasonsRepositoryV1 implements SeasonsRepository {
  final ApiMonolito _apiMonolito;

  SeasonsRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'seasons';

  @override
  Future<void> creatDocument({required TemporadaModel objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: SeasonsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<TemporadaModel?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/$id',
    );
    if (result.data.isEmpty) {
      return null;
    }
    return SeasonsDto.fromMap(result.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required TemporadaModel objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$feature/${objeto.id}',
      body: SeasonsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<TemporadaModel>> listDocument({TemporadasParams? where}) async {
    final filter = [];
    if (where != null) {
      if (where.userId != null) {
        filter.add('userId=${where.userId}&');
      }
    }
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/list?',
    );

    return result.data.map((e) => SeasonsDto.fromMap(e).toEntity()).toList();
  }
}
