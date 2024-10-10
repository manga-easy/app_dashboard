import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/dtos/create_recommendations_dto.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/dtos/recommendations_dto.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class RecommendationsRepository {
  final ApiMonolith _apiMonolito;

  RecommendationsRepository(this._apiMonolito);

  String get feature => 'recommendations';

  Future<RecommendationsEntity?> getDocument({required String id}) async {
    final result = await _apiMonolito.get('$feature/v1/$id');
    if (result.isEmpty) {
      return null;
    }
    return RecommendationsDto.fromMap(result).toEntity();
  }

  Future<void> updateDocument({
    required CreateRecommendationsDto objeto,
    required String id,
  }) async {
    await _apiMonolito.put(
      '$feature/v1/$id',
      body: objeto.toMap(),
    );
  }

  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(
      '$feature/v1/$id',
    );
  }

  Future<void> creatDocument({required CreateRecommendationsDto objeto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: objeto.toMap(),
    );
  }

  Future<List<RecommendationsEntity>> listDocument({
    RecommendationsFilter? filter,
  }) async {
    String parans = '';
    if (filter != null) {
      if (filter.page != null) {
        parans += 'page=${filter.page}&';
      }
    }
    final result = await _apiMonolito.get('$feature/v1?$parans');
    return result
        .map<RecommendationsEntity>(
          (e) => RecommendationsDto.fromMap(e).toEntity(),
        )
        .toList();
  }

  Future<RecommendationsEntity> updateImage({
    required String id,
    required XFile file,
  }) async {
    final result = await _apiMonolito.put(
      '$feature/v1/$id/images',
      body: {
        'file': MultipartFile.fromBytes(
          await file.readAsBytes(),
          filename: file.name,
          contentType: MediaType.parse(file.mimeType ?? ''),
        ),
      },
      isformData: true,
    );
    return RecommendationsDto.fromMap(result.first).toEntity();
  }
}
