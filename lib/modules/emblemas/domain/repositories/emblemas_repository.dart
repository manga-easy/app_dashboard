import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

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
  Future<List<Emblema>> listDocument({EmblemaParams? where}) async {
    var ret = await db.database.listDocuments(collectionId: table);
    return ret.documents.map((e) => Emblema.fromJson(e.data)).toList();
  }

  @override
  Future<void> updateDocument({required Emblema objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }
}
