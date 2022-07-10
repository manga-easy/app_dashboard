import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UserRepositoryExternal {
  final AppwriteAdmin appwriteAdmin;
  UserRepositoryExternal({required this.appwriteAdmin});

  Future<List<User>> list({required String? search}) async {
    var ret = await appwriteAdmin.users.list(search: search);
    return ret.users.map((e) => User.fromJson(e.toMap())).toList();
  }
}
