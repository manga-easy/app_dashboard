import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

abstract class IInforComicRepository {
  final AppwriteAdmin appwriteAdmin;

  IInforComicRepository(this.appwriteAdmin);

  Future<List<InfoComicModel>> list({required String search});
}
