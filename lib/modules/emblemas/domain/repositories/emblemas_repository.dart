import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EmblemasRepository extends IRepoExternal<Emblema, EmblemaParams> {
  @override
  String get table => Emblema.collectionId;

  EmblemasRepository(super.db);

  @override
  Future<void> creatDocument({required Emblema objeto}) async {
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
  Future<Emblema?> getDocument({required String id}) async {
    try {
      var ret = await db.database.getDocument(
        collectionId: table,
        documentId: id,
      );
      return Emblema.fromJson(ret.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDocument({required Emblema objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }

  @override
  Future<DataRepoExternal<Emblema>> listDocument({EmblemaParams? where}) async {
    var filtro = [];
    if (where != null) {
      if (where.categoria != null) {
        filtro.add(Query.equal('categoria', where.categoria));
      }
    }
    var ret = await db.database.listDocuments(
      collectionId: table,
      limit: where?.limit,
      queries: filtro,
    );
    var data = ret.documents.map((e) => Emblema.fromJson(e.data)).toList();
    return DataRepoExternal(
      data: data,
      total: ret.total,
    );
  }
}
