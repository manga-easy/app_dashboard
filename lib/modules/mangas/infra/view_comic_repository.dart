import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/view_comic_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ViewComicRepository extends IViewComicRepository {
  ViewComicRepository(super.appwriteAdmin);

  @override
  Future<int> total({required String uniqueid}) async {
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: ViewsComics.collectionId,
      limit: 1,
      queries: [
        Query.notEqual('idUser', 'seila'),
        Query.notEqual('dateCria', 'seila'),
        Query.equal('uniqueid', uniqueid),
      ],
    );
    return ret.total;
  }
}
