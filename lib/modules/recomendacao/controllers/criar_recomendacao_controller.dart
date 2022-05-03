import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriarRecomendacaoController extends IController {
  final AppwriteClient app;
  final Global global;
  var nomeManga = TextEditingController();
  var link = TextEditingController();
  var descricaoRecomendacao = TextEditingController();

  CriarRecomendacaoController({
    required this.app,
    required this.global,
  });

  @override
  void onClose() {
    nomeManga.dispose();
    link.dispose();
    descricaoRecomendacao.dispose();
  }

  @override
  void onInit(BuildContext context) {}

  void criarRecomendacao(context) async {
    try {
      var rec = RecomendacoesModel(
        link: link.text,
        title: nomeManga.text,
        //descricaoRecomendacao: descricaoRecomendacao.text,
        uniqueid: Helps.convertUniqueid(nomeManga.text),
      );
      await app.database.createDocument(
        collectionId: RecomendacoesModel.collectionID,
        documentId: 'unique()',
        data: rec.toJson(),
      );
      Navigator.of(context).pop();
    } catch (e) {
      Helps.log(e);
    }
  }
}
