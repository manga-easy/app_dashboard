import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/create_permission_dto.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';

abstract interface class PermissionsRepository {
  Future<Permission?> getDocument({required String id});

  Future<Permission> updateDocument({required CreatePermissionDto objeto});

  Future<void> deletDocument({required String id});

  Future<Permission> creatDocument({required CreatePermissionDto objeto});

  Future<List<Permission>> listDocument();

  Future<Permission?> getByUser({required String userId});
}
