import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/configApp/infra/datasources/data_source_config.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

abstract class IConfigAppRepository {
  final IDataSourceConfig dataSourceConfig;

  IConfigAppRepository(this.dataSourceConfig);

  Future<ConfigAppModel> getConfig();

  Future<BlockListModel> getBlockList();

  Future<void> updateConfig(ConfigAppModel configApp);

  Future<void> updateBlockList(BlockListModel blockList);
}
