import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/banners/data/dtos/create_banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';

class BannerRepositoryV2 {
  final ApiMonolith _apiMonolito;

  BannerRepositoryV2(
    this._apiMonolito,
  );

  String get table => 'banners';

  Future<void> creatDocument({required CreateBannerDto dto}) async {
    await _apiMonolito.post(
      '$table/v1',
      body: dto.toJson(),
    );
  }

  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$table/v1/$id');
  }

  Future<void> updateDocument({
    required CreateBannerDto dto,
    required String id,
  }) async {
    await _apiMonolito.put(
      '$table/v1/$id',
      body: dto.toJson(),
    );
  }

  Future<List<BannerEntity>> listDocument() async {
    final result = await _apiMonolito.get('$table/v1');
    return result.map<BannerEntity>((e) => BannerEntity.fromJson(e)).toList();
  }

  Future<BannerEntity?> getById(String id) async {
    final result = await _apiMonolito.get('$table/v1/$id');
    return BannerEntity.fromJson(result);
  }
}
