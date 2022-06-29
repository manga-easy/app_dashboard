import 'package:dashboard_manga_easy/core/interfaces/repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UserRepo extends IRepo<User, CredencialParams?> {
  UserRepo(super.db);

  @override
  String get table => 'user';

  @override
  List<User> list({CredencialParams? where}) {
    return db.list(table: table).map((e) => User.fromJson(e)).toList();
  }

  @override
  User? get({required String id}) {
    var dados = db.get(table: table, id: id);
    if (dados == null) return null;
    return User.fromJson(dados);
  }

  @override
  Future<void> put({required User objeto}) async {
    await db.createUpdate(table: table, dados: objeto.toJson(), id: objeto.id);
  }

  @override
  Future<void> remove({required String id}) async {
    await db.delet(table: table, id: id);
  }
}
