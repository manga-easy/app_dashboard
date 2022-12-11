import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class IDataSourceConfig {
  Future<Map<String, dynamic>> getConfing();

  Future<Map<String, dynamic>> getBlockList();

  Future<void> updateConfig({required ConfigAppModel configApp});

  Future<void> updateBlockList({required BlockListModel blockList});
}
