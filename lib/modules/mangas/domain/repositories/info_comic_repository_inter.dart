import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/models/result_data.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class IInforComicRepository {
  final AppwriteAdmin appwriteAdmin;

  IInforComicRepository(this.appwriteAdmin);

  Future<ResultData<InfoComicModel>> list(
      {required String search, int? offset, String? gender});

  Future<void> update({required InfoComicModel comic});
}
