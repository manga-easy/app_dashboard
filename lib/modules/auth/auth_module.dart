import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/auth/data/repositories/credencial_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/services/logoff_service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:go_router/go_router.dart';

class AuthModule implements Module {
  @override
  void register() {
    //resgister services
    di.registerFactory(() => LogoffService(di(), di()));
    //register repositories
    di.registerFactory(
      () => CredencialRepository(di()),
    );
    //register controllers
    di.registerFactory(
      () => AuthController(di(), di(), di(), di()),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: AuthPage.route,
          builder: (context, state) => const AuthPage(),
        ),
      ];
}
