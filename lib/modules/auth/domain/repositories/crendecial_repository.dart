import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_params.dart';

interface class CredencialRepository {
  List<CredencialModel> list({CredencialParams? where}) {
    throw UnimplementedError();
  }

  CredencialModel? get({required String id}) {
    throw UnimplementedError();
  }

  Future<void> put({required CredencialModel objeto}) {
    throw UnimplementedError();
  }

  Future<void> remove({required String id}) {
    throw UnimplementedError();
  }
}
