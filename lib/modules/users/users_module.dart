import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/permissoes_repository.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/edite_nivel_user_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/users_controller.dart';

class UsersModule extends IModuleFactory {
  @override
  void register() {
    //register Repositories
    di.registerFactory(() => NivelUserRepository(di()));
    //register controllers
    di.registerFactory(() => EditeNivelUserController(nivelUserRepository: di()));
    di.registerFactory(() => UsersController(app: di(), global: di()));
    di.registerFactory(() => UsersDetalhesController(app: di(), gb: di()));
  }
}
