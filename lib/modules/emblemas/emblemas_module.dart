import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/achievements_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/cria_edita_emblema_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/emblemas_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/cria_edita_emblema_page.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/emblemas_page.dart';
import 'package:go_router/go_router.dart';

class EmblemasModule implements Module {
  @override
  void register() {
    //repositories
    di.registerFactory(() => AchievementsRepository(di()));
    //register controllers
    di.registerFactory(() => EmblemasController(di()));
    di.registerFactory(() => CriaEditaEmblemaController(di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: EmblemasPage.route,
          builder: (context, state) => const EmblemasPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const CriaEditaEmblemaPage(),
            ),
          ],
        ),
      ];
}
