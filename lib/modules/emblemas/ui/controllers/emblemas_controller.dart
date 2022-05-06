import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasController implements IController {
  var lista = <Emblema>[];
  final AppwriteAdmin app;
  var pesquisa = '';
  var status = ValueNotifier(StatusBuild.loading);
  EmblemasController({
    required this.app,
    required this.lista,
    required this.pesquisa,
  });

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    carregaEmblemas();
  }

  void carregaEmblemas() async {
    lista.clear();
    var retorno = await app.database.listDocuments(
      collectionId: Emblema.collectionId,
      limit: 100,
    );
    lista = retorno.documents.map((e) => Emblema.fromJson(e.toMap())).toList();
  }
}
