import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UserRepositoryExternal {
  final AppwriteAdmin appwriteAdmin;
  UserRepositoryExternal({required this.appwriteAdmin});

  Future<List<User>> list({required String? search}) async {
    var ret = await appwriteAdmin.users.list(search: search);
    return ret.users.map((e) => User.fromJson(e.toMap())).toList();
  }
}
