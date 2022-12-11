import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/usecases/create_emblema_case.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/usecases/update_emblema_case.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/cria_edita_emblema_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/emblemas_controller.dart';

class EmblemasModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory(() => EmblemasRepository(di()));
    di.registerFactory(() => EmblemaUserRepository(di()));
    //usercases
    di.registerFactory<CreateEmblemaCase>(
      () => CreateEmblemaCaseImpl(
        di(),
        di(),
        di(),
      ),
    );
    di.registerFactory<UpdateEmblemaCase>(
      () => UpdateEmblemaCaseImpl(
        di(),
        di(),
        di(),
      ),
    );
    di.registerFactory(() => EmblemasRepository(di()));
    //register controllers
    di.registerFactory(() => EmblemasController(di()));
    di.registerFactory(
      () => CriaEditaEmblemaController(
        null,
        updateEmblemaCase: di(),
        createEmblemaCase: di(),
      ),
    );
  }
}
