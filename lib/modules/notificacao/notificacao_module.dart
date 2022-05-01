import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';

class NotificacaoModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => NotificacaoController());
  }
}
