import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/banners/data/dtos/banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_params.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/repositories/banner_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class BannerRepositoryV2 implements BannerRepository {
  final ApiMonolito _apiMonolito;
  String get version => 'v2';

  BannerRepositoryV2(
    this._apiMonolito,
  );

  String get table => 'banners';

  @override
  Future<void> creatDocument({required BannerModel objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$table',
      body: BannerDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(
      endpoint: '$version/$table/$id',
    );
  }

  @override
  Future<BannerModel?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$table/$id',
    );
    if (result.data.isEmpty) {
      return null;
    }

    return BannerDto.fromMap(result.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required BannerModel objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$table/${objeto.id}',
      body: BannerDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<BannerModel>> listDocument({BannerParams? where}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$table/list',
    );
    return result.data.map((e) => BannerDto.fromMap(e).toEntity()).toList();
  }
}
