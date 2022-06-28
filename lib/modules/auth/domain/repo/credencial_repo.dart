import 'package:dashboard_manga_easy/core/interfaces/repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';

class CredencialRepo extends IRepo<CredencialModel, CredencialParams?> {
  CredencialRepo(super.db);

  @override
  List<CredencialModel> getAllData({CredencialParams? where}) {
    return db.list(table: 'credencial').map((e) => CredencialModel.fromJson(e)).toList();
  }

  @override
  CredencialModel? getData({required String id}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> putData({required CredencialModel objeto, required String id}) {
    // TODO: implement putData
    throw UnimplementedError();
  }

  @override
  Future<void> removeData({required String id}) {
    // TODO: implement removeData
    throw UnimplementedError();
  }
}
