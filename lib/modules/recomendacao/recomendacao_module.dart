import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';

class RecomendacaoModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => CriarRecomendacaoController(app: di(), global: di()));
    di.registerFactory(() => RecomendacaoController(app: di(), global: di()));
  }
}
