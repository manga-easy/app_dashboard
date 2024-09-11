import 'dart:io';

import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/create_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_params.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class AchievementsRepository {
  final ApiMonolith _apiMonolito;
  String get feature => 'achievements';

  AchievementsRepository(
    this._apiMonolito,
  );

  Future<void> create({required CreateAchievementDto dto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: dto.toJson(),
    );
  }

  Future<void> delete({required String id}) async {
    await _apiMonolito.delete('$feature/v1/$id');
  }

  Future<AchievementEntity?> getById({required String id}) async {
    final result = await _apiMonolito.get(
      '$feature/v1/$id',
    );
    if (result.isEmpty) {
      return null;
    }

    return AchievementEntity.fromJson(result);
  }

  Future<void> update({
    required CreateAchievementDto dto,
    required String id,
  }) async {
    await _apiMonolito.put(
      '$feature/v1/$id',
      body: dto.toJson(),
    );
  }

  Future<List<AchievementEntity>> get({AchievementParams? where}) async {
    final filtro = [];
    if (where != null) {
      if (where.categoria != null) {
        filtro.add('categoria=${where.categoria}&');
      }
    }
    final result = await _apiMonolito.get(
      '$feature/v1?',
    );

    return result
        .map<AchievementEntity>((e) => AchievementEntity.fromJson(e))
        .toList();
  }

  Future<AchievementEntity> updateImage({
    required String id,
    required File file,
  }) async {
    final result = await _apiMonolito.put(
      '$feature/$id/image',
      body: {
        'file': MultipartFile.fromFileSync(
          file.path,
          filename: basename(file.path),
          contentType: MediaType.parse(lookupMimeType(file.path) ?? ''),
        ),
      },
      isformData: true,
    );
    return AchievementEntity.fromJson(result);
  }
}
