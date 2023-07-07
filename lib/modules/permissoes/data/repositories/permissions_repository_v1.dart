import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/permissions_dto.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class PermissionsRepositoryV1 implements PermissionsRepository {
  final ApiMonolito _apiMonolito;

  PermissionsRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'hosts';

  @override
  Future<void> creatDocument({required Permissions objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: PermissionsDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) {
    // TODO: implement deletDocument
    throw UnimplementedError();
  }

  @override
  Future<Permissions?> getDocument({required String id}) {
    // TODO: implement getDocument
    throw UnimplementedError();
  }

  @override
  Future<List<Permissions>> listDocument({PermissoesParams? where}) {
    // TODO: implement listDocument
    throw UnimplementedError();
  }

  @override
  Future<void> updateDocument({required Permissions objeto}) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }
}
