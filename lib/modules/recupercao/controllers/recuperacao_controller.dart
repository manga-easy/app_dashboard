import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/models/banner_model.dart';
import 'package:dashboard_manga_easy/modules/users/models/biblioteca.dart';
import 'package:dashboard_manga_easy/modules/users/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/users/models/emblema_user.dart';
import 'package:dashboard_manga_easy/modules/users/models/historico.dart';
import 'package:dashboard_manga_easy/modules/users/models/nivel_user.dart';
import 'package:dashboard_manga_easy/modules/users/models/users.dart' as user;
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecuperacaoController extends GetxController {
  final app = Get.find<AppwriteAdmin>();
  TextEditingController userAntigo = TextEditingController();
  TextEditingController userNovo = TextEditingController();
  String? idUserOld;
  String? idUserNew;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> recuperaEmblemas() async {
    var embs = await Emblema.getOldApp();
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
    var embs = await BannerModel.getOldApp();
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

  recuperaDados() async {
    try {
      print('Procurando findUserNew');
      idUserNew = await user.Users.findUserNew(userNovo.text);
      print('Procurando findUserOld');
      idUserOld = await user.Users.findUserOld(userAntigo.text);
      if (idUserOld != null && idUserNew != null) {
        await recuperaBiblioteca();
        await recuperaEmblemaUser();
        await recuperaHistorico();
        await recuperaNivel();
        userAntigo.clear();
        userNovo.clear();
      } else {
        print('User não encontrado ');
      }
    } catch (e) {
      Get.defaultDialog(middleText: e.toString(), title: 'erro');
    }
  }

  recuperaBiblioteca() async {
    var embs = await Biblioteca.getOldApp(idUserOld!);
    var total = embs.length;
    var atual = 1;
    for (var item in embs) {
      await Future.delayed(Duration());
      print('recuperaBiblioteca - total $total atual $atual');
      atual++;
      item.idUser = idUserNew!;
      var ret = await app.database.listDocuments(
        collectionId: Biblioteca.collectionId,
        queries: [
          Query.equal('uniqueid', item.uniqueid),
          Query.equal('idUser', item.idUser),
        ],
      );
      if (ret.documents.length == 0) {
        print('recuperaBiblioteca - create $atual');
        try {
          await app.database.createDocument(
            collectionId: Biblioteca.collectionId,
            documentId: 'unique()',
            data: item.toJson(),
            write: ['role:all'],
            read: ['role:all'],
          );
        } catch (e) {
          print(e);
        }
      } else {
        print('recuperaBiblioteca - not create $atual');
      }
    }
  }

  recuperaHistorico() async {
    try {
      var embs = await Historico.getOldApp(idUserOld!);
      var total = embs.length;
      var atual = 1;
      for (var item in embs) {
        await Future.delayed(Duration());
        print('recuperaHistorico - total $total atual $atual');
        atual++;
        item.idUser = idUserNew!;
        var ret = await app.database.listDocuments(
          collectionId: Historico.collectionId,
          queries: [
            Query.equal('uniqueid', item.uniqueid),
            Query.equal('idUser', item.idUser),
          ],
        );
        if (ret.documents.length == 0) {
          try {
            print('recuperaHistorico - create $atual');
            await app.database.createDocument(
              collectionId: Historico.collectionId,
              documentId: 'unique()',
              data: item.toJson(),
              write: ['role:all'],
              read: ['role:all'],
            );
          } catch (e) {
            print(e);
          }
        } else {
          print('recuperaHistorico - not create $atual');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  recuperaNivel() async {
    var embs = await NivelUser.getOldApp(idUserOld!);
    var total = embs.length;
    var atual = 1;
    var item = embs.first;
    print('recuperaNivel - total $total atual $atual');
    item.userId = idUserNew!;
    var ret = await app.database.listDocuments(
      collectionId: NivelUser.collectionId,
      queries: [
        Query.equal('userId', item.userId),
      ],
    );
    if (ret.documents.length == 0) {
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
        print('recuperaNivel - Atualiza');
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

  recuperaEmblemaUser() async {
    var embs = await EmblemaUser.getOldApp(idUserOld!);
    var total = embs.length;
    var atual = 1;
    for (var item in embs) {
      await Future.delayed(Duration());
      print('recuperaEmblemaUser - total $total atual $atual');
      item.userId = idUserNew!;
      atual++;
      var ret = await app.database.listDocuments(
        collectionId: EmblemaUser.collectionId,
        queries: [
          Query.equal('idEmblema', item.idEmblema),
          Query.equal('userId', item.userId),
        ],
      );
      if (ret.documents.length == 0) {
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
