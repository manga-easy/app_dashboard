import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';

import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class RecomendacaoController extends IController {
  final AppwriteClient app;
  var listaRecomendacaoItens = <RecomendacoesModel>[];

  RecomendacaoController({required this.app});

  @override
  void init(BuildContext context) {
    listaRecomendacao();
  }

  void listaRecomendacao() async {
    state = StatusBuild.loading;
    listaRecomendacaoItens.clear();
    try {
      var response = await app.database.listDocuments(
        collectionId: RecomendacoesModel.collectionID,
        orderAttributes: ['dataCria'],
        orderTypes: ['DESC'],
      );
      listaRecomendacaoItens = response.documents
          .map((e) => RecomendacoesModel.fromJson(e.data))
          .toList();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
      Helps.log(e);
    }
  }

  Future<void> deleteRecomendacao(RecomendacoesModel reco, context) async {
    try {
      await app.database.deleteDocument(
        collectionId: RecomendacoesModel.collectionID,
        documentId: reco.id!,
      );
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Recomendação deletada com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }
}
