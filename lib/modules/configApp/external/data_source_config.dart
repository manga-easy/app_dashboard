import 'package:dashboard_manga_easy/modules/configApp/infra/datasources/data_source_config.dart';
import 'package:dio/dio.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class DataSourceConfig implements IDataSourceConfig {
  final String host = 'http://micro-config.lucas-cm.com.br';
  final String version = 'v1';
  final Dio dio = Dio();
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
    var token = await authentication();
    await dio.put(
      '$host/$version/config',
      data: configApp.toJson(),
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  @override
  Future<void> updateBlockList({required BlockListModel blockList}) async {
    var token = await authentication();
    await dio.put(
      '$host/$version/block_list',
      data: blockList.toJson(),
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  Future<String> authentication() async {
    var ret = await dio.post(
      '$host/$version/authenticate',
      data: {
        "email": "mangaeasysuporte@gmail.com",
        "password": "Easy@2020",
      },
    );
    return ret.data['Token'];
  }
}
