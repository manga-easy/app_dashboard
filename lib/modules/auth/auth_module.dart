import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/auth/data/repositories/credencial_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';

class AuthModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory<CredencialRepository>(
      () => CredencialRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(
      () => AuthController(di(), di(), di(), di()),
    );
  }
}
