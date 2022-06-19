import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class MangasController extends IController {
  final AppwriteAdmin appwriteAdmin;
  final Global global;
  var mangas = ValueNotifier(<InfoComicModel>[]);
  var status = ValueNotifier(StatusBuild.loading);

  MangasController({required this.appwriteAdmin, required this.global});

  @override
  void onClose() {
    mangas.dispose();
    status.dispose();
  }

  @override
  void onInit(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    carregarMangas();
  }

  void carregarMangas() async {
    try {
      var ret = await appwriteAdmin.database.listDocuments(
        collectionId: InfoComicModel.collectionId,
        limit: 100,
        orderAttributes: ['dateUp'],
        orderTypes: ['DESC'],
      );
      mangas.value = ret.documents.map((e) => InfoComicModel.fromJson(e.data)).toList();
      status.value = StatusBuild.done;
    } catch (e) {
      status.value = StatusBuild.erro;
    }
  }
}
