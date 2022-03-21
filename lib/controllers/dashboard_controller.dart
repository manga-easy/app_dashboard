import 'package:dashboard_manga_easy/services/appwrite.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final app = Get.find<Appwrite>();
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  // void resetarxp() async {
  //   for (var i = 0; i <= 100; i++) {
  //     var retorno = await app.database.listDocuments(
  //       collectionId: NivelUser.collectionId,
  //       limit: 100,
  //       offset: 100 * i,
  //       orderAttributes: ['minute'],
  //       orderTypes: ['DESC'],
  //     );

  //     if (retorno.documents.isEmpty) {
  //       break;
  //     }
  //     print(i);
  //     print(retorno.documents.length);
  //     for (var item in retorno.documents) {
  //       var lvl = NivelUser.fromJson(item.data);
  //       lvl.lvl = 0;
  //       lvl.minute = 0;
  //       lvl.quantity = 0;
  //       lvl.timeUp = DateTime.now().millisecondsSinceEpoch;
  //       app.database.updateDocument(
  //         collectionId: NivelUser.collectionId,
  //         documentId: lvl.id!,
  //         data: lvl.toJson(),
  //       );
  //     }
  //   }
  // }
}
