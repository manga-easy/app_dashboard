import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ConfigAppRepository extends IConfigAppRepository {
  ConfigAppRepository(super.dataSourceConfig);

  @override
  Future<ConfigAppModel> get() async {
    var ret = await dataSourceConfig.getConfing();
    return ConfigAppModel.fromJson(ret);
  }

  @override
  Future<void> update(ConfigAppModel configApp) async {
    await dataSourceConfig.updateConfig(configApp: configApp);
  }
}
