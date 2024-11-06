import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:go_router/go_router.dart';

class DashboardModule implements Module {
  @override
  void register() {
    //register controllers
    di.registerFactory(
      () => DashboardController(
        serviceRoute: di(),
        userAchievementRepository: di(),
        emblemasRepository: di(),
      ),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: MainPage.route,
          builder: (context, state) => const MainPage(),
        ),
      ];
}
