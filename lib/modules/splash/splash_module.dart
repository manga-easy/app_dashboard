import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/splash/controllers/splash_controller.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
import 'package:go_router/go_router.dart';

class SplashModule implements Module {
  @override
  void register() {
    di.registerFactory(() => SplashController());
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: SplashPage.route,
          builder: (context, state) => const SplashPage(),
        ),
      ];
}
