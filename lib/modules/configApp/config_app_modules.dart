import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/configApp/infa/config_app_repository.dart';

class ConfigAppModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory<IConfigAppRepository>(() => ConfigAppRepository(di()));
  }
}
