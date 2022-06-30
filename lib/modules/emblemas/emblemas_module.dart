import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/cria_edita_emblema_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/emblemas_controller.dart';

class EmblemasModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory(() => EmblemasRepository(di()));
    //register controllers
    di.registerFactory(() => EmblemasController(emblemasRepository: di()));
    di.registerFactory(() => CriaEditaEmblemaController(emblemasRepository: di()));
  }
}
