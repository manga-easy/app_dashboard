import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_model.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_params.dart';

interface class BannerRepository {
  Future<void> creatDocument({required BannerModel objeto}) {
    throw UnimplementedError();
  }

  Future<void> deletDocument({required String id}) {
    throw UnimplementedError();
  }

  Future<BannerModel?> getDocument({required String id}) async {
    throw UnimplementedError();
  }

  Future<void> updateDocument({required BannerModel objeto}) async {
    throw UnimplementedError();
  }

  Future<List<BannerModel>> listDocument({BannerParams? where}) async {
    throw UnimplementedError();
  }
}
