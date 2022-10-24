import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/models/result_data.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/info_comic_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class InfoComicRepository extends IInforComicRepository {
  InfoComicRepository(super.appwriteAdmin);

  @override
  Future<ResultData<InfoComicModel>> list({required String search, int? offset, String? gender}) async {
    var queries = [];
    if (search.isNotEmpty) {
      queries.add(Query.search('name', search.trim()));
    }
    if (gender != null) {
      queries.add(Query.search('generos', gender));
    }

    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: InfoComicModel.collectionId,
      limit: 25,
      offset: offset,
      orderAttributes: ['dateUp'],
      orderTypes: ['DESC'],
      queries: queries,
    );

    return ResultData(
      ret.documents.map((e) => InfoComicModel.fromJson(e.data)).toList(),
      ret.total,
    );
  }

  @override
  Future<void> update({required InfoComicModel comic}) async {
    await appwriteAdmin.database.updateDocument(
      collectionId: InfoComicModel.collectionId,
      documentId: comic.id!,
      data: comic.toJson(),
    );
  }
}
