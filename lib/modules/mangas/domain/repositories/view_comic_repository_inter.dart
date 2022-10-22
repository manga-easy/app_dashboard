import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

abstract class IViewComicRepository {
  final AppwriteAdmin appwriteAdmin;

  IViewComicRepository(this.appwriteAdmin);

  Future<int> total({required String uniqueid});
}
