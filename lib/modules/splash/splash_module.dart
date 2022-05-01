import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/splash/controllers/splash_controller.dart';

class SplashModule extends IModuleFactory {
  @override
  void register() {
    di.registerFactory(() => SplashController());
  }
}
