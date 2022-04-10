import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/models/recomendacao_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  criarRecomendacao() async {
    try {
      Recomendacao rec = new Recomendacao(
        generos: generos,
        link: link.text,
        nomeManga: nomeManga.text,
        descricaoRecomendacao: descricaoRecomendacao.text,
        uniqueid: 'unique()',
      );
      await app.database.createDocument(
        collectionId: Recomendacao.collectionId,
        documentId: 'unique()',
        data: rec.toJson(),
      );
      Get.back();
    } catch (e) {
      AppHelps.log(e);
    }
  }
}
