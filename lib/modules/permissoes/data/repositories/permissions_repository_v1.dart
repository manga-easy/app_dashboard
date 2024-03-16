import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/permissions_dto.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissions_model.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';

class PermissionsRepositoryV1 implements PermissionsRepository {
  final ApiMonolito _apiMonolito;

  PermissionsRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'permissions';

  @override
  Future<void> creatDocument({required Permissions objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: PermissionsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(endpoint: '$version/$feature/$id');
  }

  @override
  Future<Permissions?> getDocument({required String id}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/$id',
    );
    if (result.data.isEmpty) {
      return null;
    }
    return PermissionsDto.fromMap(result.data.first).toEntity();
  }

  @override
  Future<List<Permissions>> listDocument({PermissoesParams? where}) async {
    String filter = '';
    if (where != null) {
      if (where.userId != null) {
        filter += 'userId=${where.userId}&';
      }
    }
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/list?$filter',
    );
    return result.data
        .map((e) => PermissionsDto.fromMap(e).toEntity())
        .toList();
  }

  @override
  Future<void> updateDocument({required Permissions objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$feature/${objeto.id}',
      body: PermissionsDto.fromEntity(objeto).toMap(),
    );
  }
}
