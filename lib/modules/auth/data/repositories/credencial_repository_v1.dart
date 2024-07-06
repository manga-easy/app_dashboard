import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';

class CredencialRepository {
  final PersistentDatabaseSembast _database;
  CredencialRepository(this._database);

  StoreSembast get table => StoreSembast.credencial;

  Future<CredencialModel?> get() async {
    final dados = await _database.get(store: table, id: 'CredencialModel');
    if (dados == null) {
      return null;
    }
    return CredencialModel.fromJson(dados);
  }

  Future<void> put({required CredencialModel objeto}) async {
    await _database.create(
      store: table,
      objeto: objeto.toJson(),
      id: 'CredencialModel',
    );
  }

  Future<void> remove() async {
    await _database.delete(store: table, id: 'CredencialModel');
  }
}
