import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/cria_edita_emblema_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/emblemas_controller.dart';

class EmblemasModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => EmblemasController(app: di()));
    di.registerFactory(() => CriaEditaEmblemaController(app: di()));
  }
}
