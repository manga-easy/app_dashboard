import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/repositories/notificacao_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/send_notification_page.dart';
import 'package:go_router/go_router.dart';

class NotificacaoModule implements Module {
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

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: NotificacaoPage.route,
          builder: (context, state) => const NotificacaoPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const SendNotificationPage(),
            ),
          ],
        ),
      ];
}
