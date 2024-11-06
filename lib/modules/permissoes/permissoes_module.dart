import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/repositories/permissions_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/edit_permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/permissoes_page.dart';
import 'package:go_router/go_router.dart';

class PermissoesModule implements Module {
  @override
  void register() {
    //register repositories
    di.registerFactory<PermissionsRepository>(
      () => PermissionsRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(() => PermissoesController(di(), di()));
    di.registerFactory(() => EditPermissoesController(di(), di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: PermissoesPage.route,
          builder: (context, state) => const PermissoesPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const EditPermissoesPage(),
            ),
          ],
        ),
      ];
}
