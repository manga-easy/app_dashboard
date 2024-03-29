import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';

abstract interface class CredencialRepository {
  Future<List<CredencialModel>> list({CredencialParams? where});
  Future<CredencialModel?> get({required String id});

  Future<void> put({required CredencialModel objeto});

  Future<void> remove({required String id});
}
