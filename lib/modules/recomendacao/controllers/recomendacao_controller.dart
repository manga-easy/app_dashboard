import 'package:appwrite/models.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/models/recomendacao_model.dart';
import 'package:get/get.dart';

class RecomendacaoController extends GetxController {
  final app = Get.find<AppwriteClient>();
  List listaRecomendacaoItens = [].obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  listaRecomendacao() async {
    listaRecomendacaoItens.clear();
    try {
      DocumentList response = await app.database.listDocuments(
        collectionId: Recomendacao.collectionId,
      );
      for (var item in response.documents) {
        listaRecomendacaoItens.add(
          Recomendacao.fromJson(item.data),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
