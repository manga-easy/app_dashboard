import 'package:dashboard_manga_easy/core/services/appwrite_old.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class GetOldBannerModelCase {
  var repository = AppwriteOld();
  
  Future<List<BannerModel>> call() async {
    final List<BannerModel> emblemas = [];
    repository.inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await repository.database.listDocuments(
        collectionId: BannerModel.collectionID,
        limit: 100,
        offset: 100 * i,
      );
      print(favos.documents.length);
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        emblemas.add(BannerModel.fromJson(favo.data));
      }
    }
    return emblemas;
  }
}
