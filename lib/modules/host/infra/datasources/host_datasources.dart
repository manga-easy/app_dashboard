import 'package:dashboard_manga_easy/modules/host/domain/entities/host_filter.dart';

abstract class HostDatasource {
  Future<Map<String, dynamic>> getDocument({required String id});

  Future<void> updateDocument({
    required Map<String, dynamic> objeto,
    required String id,
  });

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required Map<String, dynamic> objeto});

  Future<List<Map<String, dynamic>>> listDocument(HostFilter? where);
}
