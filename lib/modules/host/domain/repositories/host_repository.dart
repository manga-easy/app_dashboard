import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_model.dart';

abstract interface class HostRepository {
  Future<HostModel?> getDocument({required String id});

  Future<void> updateDocument({required HostModel objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required HostModel objeto});

  Future<List<HostModel>> listDocument({HostFilter? where});
}
