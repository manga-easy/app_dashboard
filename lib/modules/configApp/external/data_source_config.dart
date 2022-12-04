import 'package:dashboard_manga_easy/modules/configApp/infra/datasources/data_source_config.dart';
import 'package:dio/dio.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class DataSourceConfig implements IDataSourceConfig {
  final String host = 'http://micro-config.lucas-cm.com.br';
  final String version = 'v1';
  final Dio dio = Dio(
    BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 5 * 1000, // 60 seconds
        receiveTimeout: 5 * 1000 // 60 seconds
        ),
  );
  @override
  Future<Map<String, dynamic>> getBlockList() async {
    var ret = await dio.get(
      '$host/$version/block_list',
    );
    return ret.data;
  }

  @override
  Future<Map<String, dynamic>> getConfing() async {
    var ret = await dio.get('$host/$version/config');
    return ret.data;
  }

  @override
  Future<void> updateConfig({required ConfigAppModel configApp}) async {
    await dio.put(
      '$host/$version/config',
      data: configApp.toJson(),
    );
  }

  @override
  Future<void> updateBlockList({required BlockListModel blockList}) async {
    await dio.put(
      '$host/$version/block_list',
      data: blockList.toJson(),
    );
  }
}
