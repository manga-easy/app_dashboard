import 'package:dashboard_manga_easy/core/services/appwrite.dart';
import 'package:dashboard_manga_easy/modules/users/models/emblema.dart';

import 'package:get/get.dart';

class Global extends GetxService {
  final app = Get.find<Appwrite>();
  List<Emblema> listEmblema = [];
  Future<Global> inicia() async {
    carregaEmblemas();
    return this;
  }

  carregaEmblemas() async {
    listEmblema.clear();
    var retorno = await app.database.listDocuments(limit: 100, collectionId: Emblema.collectionId);

    for (var item in retorno.documents) {
      listEmblema.add(
        Emblema.fromJson(item.data),
      );
    }
  }
}
