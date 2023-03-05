import 'package:dashboard_manga_easy/modules/configApp/infra/datasources/data_source_config.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class IConfigAppRepository {
  final IDataSourceConfig dataSourceConfig;

  IConfigAppRepository(this.dataSourceConfig);

  Future<ConfigAppModel> getConfig();

  Future<BlockListModel> getBlockList();

  Future<void> updateConfig(ConfigAppModel configApp);

  Future<void> updateBlockList(BlockListModel blockList);
}
