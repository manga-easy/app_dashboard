import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecomendacaoController extends IController {
  final AppwriteClient app;
  var listaRecomendacaoItens = ValueNotifier(<RecomendacoesModel>[]);

  RecomendacaoController({required this.app});

  @override
  void onClose() {
    listaRecomendacaoItens.dispose();
  }

  @override
  void onInit(BuildContext context) {
    listaRecomendacao();
  }

  void listaRecomendacao() async {
    listaRecomendacaoItens.value.clear();
    try {
      var response = await app.database.listDocuments(
        collectionId: RecomendacoesModel.collectionID,
      );
      listaRecomendacaoItens.value =
          response.documents.map((e) => RecomendacoesModel.fromJson(e.data)).toList();
    } catch (e) {
      Helps.log(e);
    }
  }
}
