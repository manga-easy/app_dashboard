import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_block_list_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_block_list_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/external/data_source_config.dart';
import 'package:dashboard_manga_easy/modules/configApp/infra/datasources/data_source_config.dart';
import 'package:dashboard_manga_easy/modules/configApp/infra/repositories/config_app_repository.dart';
import 'package:dashboard_manga_easy/modules/configApp/presenter/controllers/config_app_controllers.dart';

class ConfigAppModule extends IModuleFactory {
  @override
  void register() {
    //datasource
    di.registerFactory<IDataSourceConfig>(() => DataSourceConfig());
    //repositories
    di.registerFactory<IConfigAppRepository>(() => ConfigAppRepository(di()));
    //usecases
    di.registerFactory(() => GetBlockListCase(di()));
    di.registerFactory(() => GetConfigAppCase(di()));
    di.registerFactory(() => UpBlockListCase(di()));
    di.registerFactory(() => UpConfigAppCase(di()));
    //controllers
    di.registerFactory(
      () => ConfigAppController(
        getConfigAppCase: di(),
        upConfigAppCase: di(),
      ),
    );
  }
}
