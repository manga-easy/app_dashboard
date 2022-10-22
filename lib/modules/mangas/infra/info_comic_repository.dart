import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/info_comic_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class InfoComicRepository extends IInforComicRepository {
  @override
  Future<List<InfoComicModel>> list({required String search}) async {
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: InfoComicModel.collectionId,
      limit: 100,
      orderAttributes: ['dateUp'],
      orderTypes: ['DESC'],
      queries: search.isNotEmpty ? [Query.search('name', search.trim())] : null,
    );
    return ret.documents.map((e) => InfoComicModel.fromJson(e.data)).toList();
  }
}
