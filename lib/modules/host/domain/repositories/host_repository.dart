import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/infra/datasources/host_datasources.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class HostRepository {
  final HostDatasource hostDatasource;

  HostRepository(this.hostDatasource);

  Future<HostModel?> getDocument({required String id});

  Future<void> updateDocument({required HostModel objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required HostModel objeto});

  Future<List<HostModel>> listDocument({HostFilter? where});
}
