import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/dtos/recommendations_dto.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';

class RecommendationsRepositoryV1 implements RecommendationsRepository {
  final ApiMonolito _apiMonolito;

  RecommendationsRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'recommendations';
  @override
  Future<RecomendacoesModel?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(endpoint: '$version/$feature/$id');
    if (result.data.isEmpty) {
      return null;
    }
    return RecommendationsDto.fromMap(result.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required RecomendacoesModel objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$feature/${objeto.id}',
      body: RecommendationsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(
      endpoint: '$version/$feature/$id',
    );
  }

  @override
  Future<void> creatDocument({required RecomendacoesModel objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: RecommendationsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<RecomendacoesModel>> listDocument({
    RecommendationsFilter? filter,
  }) async {
    String parans = '?';
    if (filter != null) {
      if (filter.uniqueid != null) {
        parans += 'uniqueid=${filter.uniqueid}&';
      }
    }
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/list$parans',
    );
    return result.data
        .map((e) => RecommendationsDto.fromMap(e).toEntity())
        .toList();
  }
}
