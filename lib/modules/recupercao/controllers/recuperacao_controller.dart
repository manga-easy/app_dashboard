import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_banner_model_case.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_biblioteca_case.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_emblema_user.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_emblemas_case.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_historico_case.dart';
import 'package:dashboard_manga_easy/modules/recupercao/cases/get_old_nivel_user_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecuperacaoController extends IController {
  final AppwriteAdmin app;
  final Global global;
  var userAntigo = TextEditingController();
  var userNovo = TextEditingController();
  var caseOldEmblema = GetOldEmblemasCase();
  var caseOldBannerModel = GetOldBannerModelCase();
  var caseOldBiblioteca = GetOldBibliotecaCase();
  var caseOldNivelUser = GetOldNivelUserCase();
  var caseOldEmblemaUser = GetOldEmlemaUser();
  var caseOldHistorico = GetOldHistoricoCase();
  String? idUserOld;
  String? idUserNew;

  RecuperacaoController({required this.app, required this.global});

  @override
  void onClose() {
    userAntigo.dispose();
    userNovo.dispose();
  }

  @override
  void onInit(BuildContext context) {}

  Future<void> recuperaEmblemas() async {
    var embs = await caseOldEmblema();
    for (var item in embs) {
      await app.database.createDocument(
        collectionId: Emblema.collectionId,
        documentId: item.id,
        data: item.toJson(),
        write: ['role:all'],
        read: ['role:all'],
      );
    }
  }

  Future<void> recuperaBanner() async {
    var embs = await caseOldBannerModel();
    for (var item in embs) {
      await app.database.createDocument(
        collectionId: BannerModel.collectionID,
        documentId: item.id,
        data: item.toJson(),
        write: ['role:all'],
        read: ['role:all'],
      );
    }
  }

  Future<void> recuperaDados(context) async {
    try {
      if (kDebugMode) {
        print('Procurando findUserNew');
      }
      idUserNew = userNovo.text;
      if (kDebugMode) {
        print('Procurando findUserOld');
      }
      idUserOld = userAntigo.text;
      if (idUserOld != null && idUserNew != null) {
        await recuperaBiblioteca();
        await recuperaEmblemaUser();
        await recuperaHistorico();
        await recuperaNivel();
        userAntigo.clear();
        userNovo.clear();
      } else {
        if (kDebugMode) {
          print('User não encontrado ');
        }
      }
    } catch (e) {
      AppHelps.confirmaDialog(
        content: e.toString(),
        title: 'erro',
        context: context,
      );
    }
  }

  Future<void> recuperaBiblioteca() async {
    var embs = await caseOldBiblioteca(idUserOld!);
    var total = embs.length;
    var atual = 1;
    for (var item in embs) {
      await Future.delayed(const Duration());
      if (kDebugMode) {
        print('recuperaBiblioteca - total $total atual $atual');
      }
      atual++;
      item.idUser = idUserNew!;
      var ret = await app.database.listDocuments(
        collectionId: Biblioteca.collectionId,
        queries: [
          Query.equal('uniqueid', item.uniqueid),
          Query.equal('idUser', item.idUser),
        ],
      );
      if (ret.documents.isEmpty) {
        if (kDebugMode) {
          print('recuperaBiblioteca - create $atual');
        }
        try {
          await app.database.createDocument(
            collectionId: Biblioteca.collectionId,
            documentId: 'unique()',
            data: item.toJson(),
            write: ['role:all'],
            read: ['role:all'],
          );
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      } else {
        if (kDebugMode) {
          print('recuperaBiblioteca - not create $atual');
        }
      }
    }
  }

  Future<void> recuperaHistorico() async {
    try {
      var embs = await caseOldHistorico(idUserOld!);
      var total = embs.length;
      var atual = 1;
      for (var item in embs) {
        await Future.delayed(const Duration());
        if (kDebugMode) {
          print('recuperaHistorico - total $total atual $atual');
        }
        atual++;
        item.idUser = idUserNew!;
        var ret = await app.database.listDocuments(
          collectionId: Historico.collectionId,
          queries: [
            Query.equal('uniqueid', item.uniqueid),
            Query.equal('idUser', item.idUser),
          ],
        );
        if (ret.documents.isEmpty) {
          try {
            if (kDebugMode) {
              print('recuperaHistorico - create $atual');
            }
            await app.database.createDocument(
              collectionId: Historico.collectionId,
              documentId: 'unique()',
              data: item.toJson(),
              write: ['role:all'],
              read: ['role:all'],
            );
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        } else {
          if (kDebugMode) {
            print('recuperaHistorico - not create $atual');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> recuperaNivel() async {
    var embs = await caseOldNivelUser(idUserOld!);
    var total = embs.length;
    var atual = 1;
    if (total > 0) {
      var item = embs.first;
      if (kDebugMode) {
        print('recuperaNivel - total $total atual $atual');
      }
      item.userId = idUserNew!;
      var ret = await app.database.listDocuments(
        collectionId: NivelUser.collectionId,
        queries: [
          Query.equal('userId', item.userId),
        ],
      );
      if (ret.documents.isEmpty) {
        await app.database.createDocument(
          collectionId: NivelUser.collectionId,
          documentId: item.id!,
          data: item.toJson(),
          write: ['role:all'],
          read: ['role:all'],
        );
      } else {
        var atual = NivelUser.fromJson(ret.documents.first.data);
        if (atual.lvl < item.lvl) {
          if (kDebugMode) {
            print('recuperaNivel - Atualiza');
          }
          atual.lvl = item.lvl;
          atual.minute = item.minute;
          atual.quantity = item.quantity;
        }
        await app.database.updateDocument(
          collectionId: NivelUser.collectionId,
          documentId: atual.id!,
          data: atual.toJson(),
        );
      }
    }
  }

  Future<void> recuperaEmblemaUser() async {
    var embs = await caseOldEmblemaUser(idUserOld!);
    var total = embs.length;
    var atual = 1;
    for (var item in embs) {
      await Future.delayed(const Duration());
      if (kDebugMode) {
        print('recuperaEmblemaUser - total $total atual $atual');
      }
      item.userId = idUserNew!;
      atual++;
      var ret = await app.database.listDocuments(
        collectionId: EmblemaUser.collectionId,
        queries: [
          Query.equal('idEmblema', item.idEmblema),
          Query.equal('userId', item.userId),
        ],
      );
      if (ret.documents.isEmpty) {
        await app.database.createDocument(
          collectionId: EmblemaUser.collectionId,
          documentId: item.id!,
          data: item.toJson(),
          write: ['role:all'],
          read: ['role:all'],
        );
      }
    }
  }
}
