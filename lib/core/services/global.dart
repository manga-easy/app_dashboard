import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/service.dart';

class Global extends IService {
  String? user;
  Future<Global> inicia() async {
    return this;
  }

  // carregaEmblemas() async {
  //   listEmblema.clear();
  //   var retorno = await app.database.listDocuments(limit: 100, collectionId: Emblema.collectionId);

  //   for (var item in retorno.documents) {
  //     listEmblema.add(
  //       Emblema.fromJson(item.data),
  //     );
  //   }
  // }

  @override
  Future<void> initialise() async {}
}
