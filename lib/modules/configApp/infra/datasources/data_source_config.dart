import 'package:sdk_manga_easy/sdk_manga_easy.dart';

abstract class IDataSourceConfig {
  Future<Map<String, dynamic>> getConfing();

  Future<Map<String, dynamic>> getBlockList();

  Future<void> updateConfig({required ConfigAppModel configApp});

  Future<void> updateBlockList({required BlockListModel blockList});
}
