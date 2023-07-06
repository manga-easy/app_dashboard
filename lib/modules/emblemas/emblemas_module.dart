import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/cria_edita_emblema_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/emblemas_controller.dart';

class EmblemasModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory<EmblemasRepository>(() => EmblemasRepositoryV1(di()));
    di.registerFactory<EmblemaUserRepository>(
      () => EmblemaUserRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(() => EmblemasController(di()));
    di.registerFactory(() => CriaEditaEmblemaController(di()));
  }
}
