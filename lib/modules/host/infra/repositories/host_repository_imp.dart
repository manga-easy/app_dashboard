import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostRepositoryImp extends HostRepository {
  HostRepositoryImp(super.hostDatasource);

  @override
  Future<void> creatDocument({required HostModel objeto}) async {
    await hostDatasource.creatDocument(
      objeto: objeto.toJson(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await hostDatasource.deletDocument(id: id);
  }

  @override
  Future<HostModel?> getDocument({required String id}) async {
    var ret = await hostDatasource.getDocument(id: id);
    return HostModel.fromJson(ret);
  }

  @override
  Future<void> updateDocument({required HostModel objeto}) async {
    await hostDatasource.updateDocument(
      id: objeto.id!,
      objeto: objeto.toJson(),
    );
  }

  @override
  Future<List<HostModel>> listDocument({HostFilter? where}) async {
    var ret = await hostDatasource.listDocument(where);
    return ret.map((e) => HostModel.fromJson(e)).toList();
  }
}
