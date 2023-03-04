import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';

class NotificacaoModule extends IModuleFactory {
  @override
  void register() {
    //register Repositores
    di.registerFactory(() => NotificacaoRepository(di()));
    //register controllers
    di.registerFactory(() => SendNotificationController(notificacaoRepository: di(), userRepo: di()));
    di.registerFactory(() => NotificacaoController(notificacaoRepository: di(), ));
  }
}
