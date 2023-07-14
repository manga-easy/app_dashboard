import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/repositories/notificacao_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';

class NotificacaoModule extends IModuleFactory {
  @override
  void register() {
    //register Repositores
    di.registerFactory<NotificacaoRepository>(
      () => NotificacaoRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(() => SendNotificationController(di(), di()));
    di.registerFactory(
      () => NotificacaoController(
        di(),
      ),
    );
  }
}
