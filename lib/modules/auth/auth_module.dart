import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/credencial_repo.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repo.dart';

class AuthModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => CredencialRepo(di()));
    di.registerFactory(() => UserRepo(di()));
    //register controllers
    di.registerFactory(
      () => AuthController(
        app: di(),
        serviceRoute: di(),
        credencialRepo: di(),
      ),
    );
  }
}
