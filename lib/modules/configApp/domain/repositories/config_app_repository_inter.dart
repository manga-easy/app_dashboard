import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

abstract class IConfigAppRepository {
  final AppwriteAdmin appwriteAdmin;

  IConfigAppRepository(this.appwriteAdmin);

  Future<ConfigAppModel> get();

  Future<void> update(ConfigAppModel configApp);
}
