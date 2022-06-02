import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/banners_controller.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/criar_banner_controller.dart';

class BannersModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => CriarBannerController(app: di(), global: di()));
    di.registerFactory(() => BannerController(app: di(), global: di()));
  }
}
