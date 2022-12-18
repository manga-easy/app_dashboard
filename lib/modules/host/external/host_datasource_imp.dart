import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/infra/datasources/host_datasources.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostDataSourceAppwrite extends HostDatasource {
  final AppwriteAdmin appwriteAdmin;

  HostDataSourceAppwrite(this.appwriteAdmin);

  @override
  Future<void> creatDocument({required Map<String, dynamic> objeto}) async {
    await appwriteAdmin.database.createDocument(
      collectionId: HostModel.collectionId,
      documentId: 'unique()',
      data: objeto,
      read: ['role:all'],
      write: ['role:all'],
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await appwriteAdmin.database.deleteDocument(
      collectionId: HostModel.collectionId,
      documentId: id,
    );
  }

  @override
  Future<Map<String, dynamic>> getDocument({required String id}) async {
    var ret = await appwriteAdmin.database.getDocument(
      collectionId: HostModel.collectionId,
      documentId: id,
    );
    return ret.data;
  }

  @override
  Future<void> updateDocument({
    required Map<String, dynamic> objeto,
    required String id,
  }) async {
    await appwriteAdmin.database.updateDocument(
      collectionId: HostModel.collectionId,
      documentId: id,
      data: objeto,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> listDocument(HostFilter? where) async {
    if (where != null) {}
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: HostModel.collectionId,
      orderAttributes: ['idHost'],
      orderTypes: ['DESC'],
    );
    return ret.documents.map((e) => e.data).toList();
  }
}
