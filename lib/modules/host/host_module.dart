import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_controller.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_details_controller.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_details_page.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_pages.dart';
import 'package:go_router/go_router.dart';

class HostModule implements Module {
  @override
  void register() {
    //repositories
    di.registerFactory(() => HostRepositoryV1(di()));
    //controllers
    di.registerFactory(() => HostDetailsController(di()));

    di.registerFactory(() => HostController(di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: HostPage.route,
          builder: (context, state) => const HostPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const HostDetailsPage(),
            ),
          ],
        ),
      ];
}
