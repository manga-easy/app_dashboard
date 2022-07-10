import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/users_controller.dart';

class UsersModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => UsersController(app: di(), global: di()));
    di.registerFactory(() => UsersDetalhesController(app: di(), gb: di()));
  }
}
