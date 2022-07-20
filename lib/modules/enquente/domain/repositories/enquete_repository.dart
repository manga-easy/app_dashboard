import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/enquente/domain/models/permissoes_params.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EnqueteRepository extends IRepoExternal<EnqueteModel, EnqueteParams> {
  @override
  String get table => EnqueteModel.collectionId;

  EnqueteRepository(super.db);

  @override
  Future<void> creatDocument({required EnqueteModel objeto}) async {
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
  Future<EnqueteModel?> getDocument({required String id}) async {
    try {
      var ret = await db.database.getDocument(
        collectionId: table,
        documentId: id,
      );
      return EnqueteModel.fromJson(ret.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDocument({required EnqueteModel objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }

  @override
  Future<DataRepoExternal<EnqueteModel>> listDocument({EnqueteParams? where}) async {
    // var filtro = [];
    // if (where != null) {
    //   if (where.userId != null) {
    //     filtro.add(Query.equal('userId', where.userId));
    //   }
    // }
    var ret = await db.database.listDocuments(
      collectionId: table,
      //queries: filtro,
    );
    var data = ret.documents.map((e) => EnqueteModel.fromJson(e.data)).toList();
    return DataRepoExternal(
      data: data,
      total: ret.total,
    );
  }
}
