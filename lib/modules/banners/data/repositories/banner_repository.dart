import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/banners/data/dtos/create_banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';

class BannerRepositoryV2 {
  final ApiMonolith _apiMonolito;

  BannerRepositoryV2(
    this._apiMonolito,
  );

  String get table => 'banners';

  Future<BannerEntity> creatDocument({required CreateBannerDto dto}) async {
    final result = await _apiMonolito.post(
      '$table/v1',
      body: dto.toJson(),
    );
    return BannerEntity.fromJson(result);
  }

  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$table/v1/$id');
  }

  Future<BannerEntity> updateDocument({
    required CreateBannerDto dto,
    required String id,
  }) async {
    final result = await _apiMonolito.put(
      '$table/v1/$id',
      body: dto.toJson(),
    );
    return BannerEntity.fromJson(result);
  }

  Future<List<BannerEntity>> listDocument() async {
    final result = await _apiMonolito.get('$table/v1');
    return result.map<BannerEntity>((e) => BannerEntity.fromJson(e)).toList();
  }
}
