import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemaUserRepository extends IRepoExternal<EmblemaUser, EmblemaUserParams> {
  @override
  String get table => EmblemaUser.collectionId;

  EmblemaUserRepository(super.db);

  @override
  Future<void> creatDocument({required EmblemaUser objeto}) async {
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
  Future<EmblemaUser?> getDocument({required String id}) async {
    try {
      var ret = await db.database.getDocument(
        collectionId: table,
        documentId: id,
      );
      return EmblemaUser.fromJson(ret.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDocument({required EmblemaUser objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }

  @override
  Future<DataRepoExternal<EmblemaUser>> listDocument({EmblemaUserParams? where}) async {
    var filtro = [];
    if (where != null) {
      if (where.idEmblema != null) {
        filtro.add(Query.equal('idEmblema', where.idEmblema));
      }
    }
    var ret = await db.database.listDocuments(
      collectionId: table,
      limit: where?.limit,
      queries: filtro,
    );
    var data = ret.documents.map((e) => EmblemaUser.fromJson(e.data)).toList();
    return DataRepoExternal(data: data, total: ret.total);
  }
}
