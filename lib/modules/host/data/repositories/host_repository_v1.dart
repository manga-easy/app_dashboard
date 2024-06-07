import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_model.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';

class HostRepositoryV1 implements HostRepository {
  final ApiMonolith _apiMonolito;

  HostRepositoryV1(this._apiMonolito);

  String get version => 'v2';
  String get feature => 'hosts';

  @override
  Future<void> creatDocument({required HostModel objeto}) async {
    await _apiMonolito.post(
      '$version/$feature',
      body: HostDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$version/$feature/$id');
  }

  @override
  Future<HostModel?> getDocument({required String id}) async {
    final result = await _apiMonolito.get('$version/$feature/$id');
    if (result['data'].isEmpty) {
      return null;
    }
    return HostDto.fromMap(result['data'].first).toEntity();
  }

  @override
  Future<void> updateDocument({required HostModel objeto}) async {
    await _apiMonolito.put(
      '$version/$feature/${objeto.id}',
      body: HostDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<HostModel>> listDocument({HostFilter? where}) async {
    final result = await _apiMonolito.get('$version/$feature/list?isAll=true');
    return result['data']
        .map<HostModel>((e) => HostDto.fromMap(e).toEntity())
        .toList();
  }
}
