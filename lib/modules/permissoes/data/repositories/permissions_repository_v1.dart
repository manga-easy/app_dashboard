import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/create_permission_dto.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';

class PermissionsRepositoryV1 implements PermissionsRepository {
  final ApiMonolith _apiMonolito;

  PermissionsRepositoryV1(this._apiMonolito);

  String get feature => 'permission';

  @override
  Future<Permission> creatDocument({
    required CreatePermissionDto objeto,
  }) async {
    final result = await _apiMonolito.post(
      '$feature/v1',
      body: objeto.toMap(),
    );

    return Permission.fromMap(result);
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$feature/v1/$id');
  }

  @override
  Future<Permission?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      '$feature/v1',
    );
    if (result.isEmpty) {
      return null;
    }
    return Permission.fromMap(result.first);
  }

  @override
  Future<List<Permission>> listDocument({PermissoesParams? where}) async {
    String filter = '';
    if (where != null) {
      if (where.userId != null) {
        filter += 'userId=${where.userId}&';
      }
    }
    final result = await _apiMonolito.get(
      '$feature/v1?$filter',
    );
    return result.map<Permission>((e) => Permission.fromMap(e)).toList();
  }

  @override
  Future<Permission> updateDocument({
    required CreatePermissionDto objeto,
  }) async {
    final result = await _apiMonolito.put(
      '$feature/v1',
      body: objeto.toMap(),
    );
    return Permission.fromMap(result);
  }
}
