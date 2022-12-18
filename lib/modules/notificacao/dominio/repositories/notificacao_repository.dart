import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class NotificacaoRepository
    extends IRepoExternal<Notificacao, FiltroNotificacao> {
  @override
  String get table => Notificacao.collectionId;

  NotificacaoRepository(super.db);

  @override
  Future<void> creatDocument({required Notificacao objeto}) async {
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
  Future<Notificacao?> getDocument({required String id}) async {
    try {
      var ret = await db.database.getDocument(
        collectionId: table,
        documentId: id,
      );
      return Notificacao.fromJson(ret.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDocument({required Notificacao objeto}) async {
    await db.database.updateDocument(
      collectionId: table,
      documentId: objeto.id!,
      data: objeto.toJson(),
    );
  }

  @override
  Future<DataRepoExternal<Notificacao>> listDocument(
      {FiltroNotificacao? where}) async {
    var filtro = [];

    var ret = await db.database.listDocuments(
      collectionId: table,
      queries: filtro,
      orderAttributes: ['\$id'],
      orderTypes: ['DESC'],
    );
    var data = ret.documents.map((e) => Notificacao.fromJson(e.data)).toList();
    return DataRepoExternal(
      data: data,
      total: ret.total,
    );
  }
}
