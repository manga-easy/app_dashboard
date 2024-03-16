import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';

class CredencialRepositoryV1 implements CredencialRepository {
  final PersistentDatabaseSembast _database;
  CredencialRepositoryV1(this._database);

  StoreSembast get table => StoreSembast.credencial;

  @override
  Future<List<CredencialModel>> list({CredencialParams? where}) async {
    final result = await _database.list(store: table);
    return result.map((e) => CredencialModel.fromJson(e)).toList();
  }

  @override
  Future<CredencialModel?> get({required String id}) async {
    final dados = await _database.get(store: table, id: id);
    if (dados == null) {
      return null;
    }
    return CredencialModel.fromJson(dados);
  }

  @override
  Future<void> put({required CredencialModel objeto}) async {
    await _database.create(
      store: table,
      objeto: objeto.toJson(),
      id: objeto.id,
    );
  }

  @override
  Future<void> remove({required String id}) async {
    await _database.delete(store: table, id: id);
  }
}
