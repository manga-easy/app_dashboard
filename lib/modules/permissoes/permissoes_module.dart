import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissoes_repository.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';

class PermissoesModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => PermissoesRepository(di()));
    //register controllers
    di.registerFactory(() => PermissoesController(appwriteAdmin: di(), permissoesRepository: di()));
    di.registerFactory(
        () => EditPermissoesController(appwriteAdmin: di(), permissoesRepository: di(), userRepo: di()));
  }
}
