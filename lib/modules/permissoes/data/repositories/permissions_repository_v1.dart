import 'package:dashboard_manga_easy/modules/permissoes/data/datasources/permissions_datasource.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class PermissionsRepositoryV1 implements PermissionsRepository {
  final PermissionsDatasource _permissionsDatasource;

  PermissionsRepositoryV1(this._permissionsDatasource);
  @override
  Future<List<Permissions>> list() async {
    final result = await _permissionsDatasource.list();
    return result.map((e) => e.toEntity()).toList();
  }
}
