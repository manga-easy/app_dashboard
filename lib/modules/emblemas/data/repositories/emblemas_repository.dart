import 'dart:io';

import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class EmblemasRepositoryV1 implements EmblemasRepository {
  final ApiMonolith _apiMonolito;
  String get version => 'v1';
  String get feature => 'achievements';

  EmblemasRepositoryV1(
    this._apiMonolito,
  );

  @override
  Future<void> creatDocument({required Emblema objeto}) async {
    await _apiMonolito.post(
      '$version/$feature',
      body: AchievementDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$version/$feature/$id');
  }

  @override
  Future<Emblema?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      '$version/$feature/$id',
    );
    if (result['data'].isEmpty) {
      return null;
    }

    return AchievementDto.fromMap(result['data'].first).toEntity();
  }

  @override
  Future<void> updateDocument({required Emblema objeto}) async {
    await _apiMonolito.put(
      '$version/$feature/${objeto.id}',
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
      '$version/$feature/list?',
    );
    final List<AchievementDto> data = result['data']
        .map<AchievementDto>((e) => AchievementDto.fromMap(e))
        .toList();
    return data.map<Emblema>((e) => e.toEntity()).toList();
  }

  @override
  Future<Emblema> updateImage({required String id, required File file}) async {
    final result = await _apiMonolito.put(
      '$version/$feature/$id/image',
      body: {
        'file': MultipartFile.fromFileSync(
          file.path,
          filename: basename(file.path),
          contentType: MediaType.parse(lookupMimeType(file.path) ?? ''),
        ),
      },
      isformData: true,
    );
    return AchievementDto.fromMap(result['data'].first).toEntity();
  }
}
