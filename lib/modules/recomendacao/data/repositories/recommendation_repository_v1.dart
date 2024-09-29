import 'dart:io';

import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/dtos/create_recommendations_dto.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/dtos/recommendations_dto.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class RecommendationsRepositoryV1 implements RecommendationsRepository {
  final ApiMonolith _apiMonolito;

  RecommendationsRepositoryV1(this._apiMonolito);

  String get feature => 'recommendations';
  @override
  Future<RecommendationsEntity?> getDocument({required String id}) async {
    final result = await _apiMonolito.get('$feature/v1/$id');
    if (result.isEmpty) {
      return null;
    }
    return RecommendationsDto.fromMap(result).toEntity();
  }

  @override
  Future<void> updateDocument({
    required CreateRecommendationsDto objeto,
    required String id,
  }) async {
    await _apiMonolito.put(
      '$feature/v1/$id',
      body: objeto.toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(
      '$feature/v1/$id',
    );
  }

  @override
  Future<void> creatDocument({required CreateRecommendationsDto objeto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: objeto.toMap(),
    );
  }

  @override
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

  @override
  Future<RecommendationsEntity> updateImage({
    required String id,
    required File file,
  }) async {
    final result = await _apiMonolito.put(
      '$feature/v1/$id/image',
      body: {
        'file': MultipartFile.fromFileSync(
          file.path,
          filename: basename(file.path),
          contentType: MediaType.parse(lookupMimeType(file.path) ?? ''),
        ),
      },
      isformData: true,
    );
    return RecommendationsDto.fromMap(result.first).toEntity();
  }
}
