import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostRepositoryV1 implements HostRepository {
  final ApiMonolito _apiMonolito;

  HostRepositoryV1(this._apiMonolito);

  String get version => 'v2';
  String get feature => 'hosts';

  @override
  Future<void> creatDocument({required HostModel objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: HostDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(endpoint: '$version/$feature/$id');
  }

  @override
  Future<HostModel?> getDocument({required String id}) async {
    final ret = await _apiMonolito.get(endpoint: '$version/$feature/$id');
    if (ret.data.isEmpty) {
      return null;
    }
    return HostDto.fromMap(ret.data.first).toEntity();
  }

  @override
  Future<void> updateDocument({required HostModel objeto}) async {
    await _apiMonolito.put(
      endpoint: '$version/$feature/${objeto.id}',
      body: HostDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<HostModel>> listDocument({HostFilter? where}) async {
    final result = await _apiMonolito.get(
      endpoint: '$version/$feature/list?isAll=true',
    );

    return result.data.map((e) => HostDto.fromMap(e).toEntity()).toList();
  }
}
