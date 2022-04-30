import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/recupercao/controllers/recuperacao_controller.dart';

class RecuperacaooModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => RecuperacaoController(app: di()));
  }
}
