import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/permissions_dto.dart';

interface class PermissionsDatasource {
  Future<List<PermissionsDto>> list() {
    throw UnimplementedError();
  }
}
