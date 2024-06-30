import 'dart:io';

import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
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

  String get version => 'v1';
  String get feature => 'recommendations';
  @override
  Future<RecomendacoesModel?> getDocument({required String id}) async {
    final result = await _apiMonolito.get('$version/$feature/$id');
    if (result['data'].isEmpty) {
      return null;
    }
    return RecommendationsDto.fromMap(result['data'].first).toEntity();
  }

  @override
  Future<void> updateDocument({required RecomendacoesModel objeto}) async {
    await _apiMonolito.put(
      '$version/$feature/${objeto.id}',
      body: RecommendationsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(
      '$version/$feature/$id',
    );
  }

  @override
  Future<void> creatDocument({required RecomendacoesModel objeto}) async {
    await _apiMonolito.post(
      '$version/$feature',
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
    final result = await _apiMonolito.get('$version/$feature/list$parans');
    return result['data']
        .map<RecomendacoesModel>(
            (e) => RecommendationsDto.fromMap(e).toEntity(),)
        .toList();
  }

  @override
  Future<RecomendacoesModel> updateImage({
    required String uniqueid,
    required File file,
  }) async {
    final result = await _apiMonolito.put(
      '$version/$feature/$uniqueid/image',
      body: {
        'file': MultipartFile.fromFileSync(
          file.path,
          filename: basename(file.path),
          contentType: MediaType.parse(lookupMimeType(file.path) ?? ''),
        ),
      },
      isformData: true,
    );
    return RecommendationsDto.fromMap(result['data'].first).toEntity();
  }
}
