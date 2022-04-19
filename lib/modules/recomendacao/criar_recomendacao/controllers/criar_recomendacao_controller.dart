import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriarRecomendacaoController extends GetxController {
  final app = Get.find<AppwriteClient>();

  TextEditingController nomeManga = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController descricaoRecomendacao = TextEditingController();
  List<String> generos = [];

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void criarRecomendacao() async {
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
      Get.back();
    } catch (e) {
      Helps.log(e);
    }
  }
}
