import 'package:dashboard_manga_easy/core/interfaces/repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';

class CredencialRepo extends IRepo<CredencialModel, CredencialParams?> {
  CredencialRepo(super.db);

  @override
  String get table => 'credencial';

  @override
  List<CredencialModel> list({CredencialParams? where}) {
    return db.list(table: table).map((e) => CredencialModel.fromJson(e)).toList();
  }

  @override
  CredencialModel? get({required String id}) {
    var dados = db.get(table: table, id: id);
    if (dados == null) return null;
    return CredencialModel.fromJson(dados);
  }

  @override
  Future<void> put({required CredencialModel objeto}) async {
    await db.createUpdate(
      table: table,
      dados: objeto.toJson(),
      id: objeto.id,
    );
  }

  @override
  Future<void> remove({required String id}) async {
    await db.delet(table: table, id: id);
  }
}
