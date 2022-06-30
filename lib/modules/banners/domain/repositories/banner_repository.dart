import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_params.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class BannerRepository extends IRepoExternal<BannerModel, BannerParams> {
  @override
  String get table => BannerModel.collectionID;

  BannerRepository(super.db);

  @override
  Future<void> creatDocument({required BannerModel objeto}) async {
    await db.database.createDocument(
      collectionId: table,
      documentId: 'unique()',
      data: objeto.toJson(),
      read: ['role:all'],
      write: ['role:all'],
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await db.database.deleteDocument(
      collectionId: table,
      documentId: id,
    );
  }

  @override
  Future<BannerModel?> getDocument({required String id}) async {
    try {
      var ret = await db.database.getDocument(
        collectionId: table,
        documentId: id,
      );
      return BannerModel.fromJson(ret.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<BannerModel>> listDocument({BannerParams? where}) async {
    var ret = await db.database.listDocuments(collectionId: table);
    return ret.documents.map((e) => BannerModel.fromJson(e.data)).toList();
  }

  @override
  Future<void> updateDocument({required BannerModel objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }
}
