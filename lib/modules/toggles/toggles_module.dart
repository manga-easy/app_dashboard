import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/toggles/data/repositories/toggle_repository.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/controllers/create_toggle_controller.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/controllers/toggle_controller.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/pages/create_toggles_page.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/pages/toggles_page.dart';
import 'package:go_router/go_router.dart';

class TogglesModule implements Module {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => ToggleRepositoryV1(di()));
    //register controllers
    di.registerFactory(
      () => CreateToggleController(di()),
    );
    di.registerFactory(
      () => ToggleController(di()),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: TogglesPage.route,
          builder: (context, state) => const TogglesPage(),
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) {
                return const CreateTogglesPage();
              },
            ),
          ],
        ),
      ];
}
