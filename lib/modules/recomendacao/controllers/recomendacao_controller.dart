import 'package:appwrite/models.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:get/get.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

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
    listaRecomendacao();
  }

  listaRecomendacao() async {
    listaRecomendacaoItens.clear();
    try {
      DocumentList response = await app.database.listDocuments(
        collectionId: RecomendacoesModel.collectionID,
      );
      for (var item in response.documents) {
        listaRecomendacaoItens.add(
          RecomendacoesModel.fromJson(item.data),
        );
      }
    } catch (e) {
      Helps.log(e);
    }
  }
}
