import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/create_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_params.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

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
    String filtro = '';
    if (where != null) {
      if (where.category != null) {
        filtro += 'category=${where.category}&';
      }
      if (where.name != null) {
        filtro += 'name=${where.name}&';
      }
    }
    final result = await _apiMonolito.get(
      '$feature/v1?$filtro',
    );
    if (result.isEmpty) {
      return [];
    }
    return result
        .map<AchievementEntity>((e) => AchievementEntity.fromJson(e))
        .toList();
  }

  Future<AchievementEntity> updateImage({
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
    return AchievementEntity.fromJson(result);
  }
}
