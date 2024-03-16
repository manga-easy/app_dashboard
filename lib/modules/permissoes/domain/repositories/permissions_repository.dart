import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissions_model.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';

abstract interface class PermissionsRepository {
  Future<Permissions?> getDocument({required String id});

  Future<void> updateDocument({required Permissions objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required Permissions objeto});

  Future<List<Permissions>> listDocument({PermissoesParams? where});
}
