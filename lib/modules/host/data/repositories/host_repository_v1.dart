import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/create_host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';

class HostRepositoryV1 {
  final ApiMonolith _apiMonolito;

  HostRepositoryV1(this._apiMonolito);

  String get feature => 'hosts';

  Future<void> creatDocument({required CreateHostDto objeto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: objeto.toJson(),
    );
  }

  Future<HostEntity?> getDocument({required String id}) async {
    final result = await _apiMonolito.get('$feature/v1/$id');
    if (result.isEmpty) {
      return null;
    }
    return HostEntity.fromJson(result);
  }

  Future<HostEntity> updateDocument({
    required CreateHostDto objeto,
    required String id,
  }) async {
    final result = await _apiMonolito.put(
      '$feature/v1/$id',
      body: objeto.toJson(),
    );
    return HostEntity.fromJson(result);
  }

  Future<List<HostEntity>> listDocument({HostFilter? where}) async {
    final result = await _apiMonolito.get('$feature/v1');
    return result.map<HostEntity>((e) => HostEntity.fromJson(e)).toList();
  }
}
