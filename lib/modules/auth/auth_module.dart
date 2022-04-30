import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';

class AuthModule extends IModuleFactory {
  void register() {
    //register controllers
    di.registerFactory(() => AuthController(app: di(), gb: di()));
  }
}
