import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecomendacaoController extends IController {
  final AppwriteClient app;
  final Global global;
  var listaRecomendacaoItens = <RecomendacoesModel>[];
  var status = ValueNotifier(StatusBuild.loading);

  RecomendacaoController({required this.app, required this.global});

  @override
  void onClose() {
    status.dispose();
  }

  @override
  void onInit(BuildContext context) {
    listaRecomendacao();
  }

  void listaRecomendacao() async {
    status.value = StatusBuild.loading;
    listaRecomendacaoItens.clear();
    try {
      var response = await app.database.listDocuments(
        collectionId: RecomendacoesModel.collectionID,
        orderAttributes: ['dataCria'],
        orderTypes: ['DESC'],
      );
      listaRecomendacaoItens = response.documents.map((e) => RecomendacoesModel.fromJson(e.data)).toList();
      status.value = StatusBuild.done;
    } catch (e) {
      status.value = StatusBuild.erro;
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
