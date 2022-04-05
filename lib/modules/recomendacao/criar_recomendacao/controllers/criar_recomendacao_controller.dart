import 'package:appwrite/models.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/models/recomendacao_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CriarRecomendacaoController extends GetxController {
  final app = Get.find<AppwriteClient>();

  TextEditingController nomeManga = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController descricaoRecomendacao = TextEditingController();

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
      Document response = await app.database.createDocument(
        collectionId: Recomendacao.collectionId,
        documentId: 'unique()',
        data: {
          'nomeManga': nomeManga.text,
          'link': link.text,
          'descricao_recomendacao': descricaoRecomendacao.text,
        },
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
