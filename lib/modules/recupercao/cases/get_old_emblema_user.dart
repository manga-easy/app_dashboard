import 'package:dashboard_manga_easy/core/services/appwrite_old.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class GetOldEmlemaUser {
  var repository = AppwriteOld();

  Future<List<EmblemaUser>> call(String user) async {
    final List<EmblemaUser> mangas = [];
    repository.inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await repository.database.listDocuments(
        collectionId: EmblemaUser.collectionId,
        limit: 100,
        offset: 100 * i,
        filters: [
          'userId=$user',
        ],
      );
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        mangas.add(EmblemaUser.fromJson(favo.data));
      }
    }
    return mangas;
  }
}
