import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';

class CredencialRepositoryV1 implements CredencialRepository {
  final HiveDb _hiveDb;
  CredencialRepositoryV1(this._hiveDb);

  String get table => 'credencial';

  @override
  List<CredencialModel> list({CredencialParams? where}) {
    return _hiveDb
        .list(table: table)
        .map((e) => CredencialModel.fromJson(e))
        .toList();
  }

  @override
  CredencialModel? get({required String id}) {
    final dados = _hiveDb.get(table: table, id: id);
    if (dados == null) return null;
    return CredencialModel.fromJson(dados);
  }

  @override
  Future<void> put({required CredencialModel objeto}) async {
    await _hiveDb.createUpdate(
      table: table,
      dados: objeto.toJson(),
      id: objeto.id,
    );
  }

  @override
  Future<void> remove({required String id}) async {
    await _hiveDb.delet(table: table, id: id);
  }
}
