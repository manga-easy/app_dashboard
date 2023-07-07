import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/levels_user_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/levels_user_repository.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/edite_nivel_user_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/users_controller.dart';

class UsersModule extends IModuleFactory {
  @override
  void register() {
    //register Repositories
    di.registerFactory<LevelsUserRepository>(
        () => LevelsUserRepositoryV1(di()));
    //register controllers
    di.registerFactory(() => EditeNivelUserController(di()));
    di.registerFactory(() => UsersController());
    di.registerFactory(
      () => UsersDetalhesController(di(), di(), di()),
    );
  }
}
