import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class ConfigAppRepository extends IConfigAppRepository {
  ConfigAppRepository(super.dataSourceConfig);

  @override
  Future<ConfigAppModel> getConfig() async {
    var ret = await dataSourceConfig.getConfing();
    return ConfigAppModel.fromJson(ret);
  }

  @override
  Future<void> updateConfig(ConfigAppModel configApp) async {
    await dataSourceConfig.updateConfig(configApp: configApp);
  }

  @override
  Future<BlockListModel> getBlockList() async {
    var ret = await dataSourceConfig.getBlockList();
    return BlockListModel.fromMap(ret);
  }

  @override
  Future<void> updateBlockList(BlockListModel blockList) async {
    await dataSourceConfig.updateBlockList(blockList: blockList);
  }
}
