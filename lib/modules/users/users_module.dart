import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/user_achievement_repository.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/users_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/users_page.dart';
import 'package:go_router/go_router.dart';

class UsersModule implements Module {
  @override
  void register() {
    //register Repositories
    di.registerFactory(
      () => UserAchievementRepository(di()),
    );
    di.registerFactory<UsersRepository>(() => UsersRepositoryV1(di()));
    di.registerFactory(() => UsersController(di()));
    di.registerFactory(
      () => UsersDetalhesController(
        di(),
        di(),
        di(),
      ),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: UsersPage.route,
          builder: (context, state) => const UsersPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const UserDetalhesPage(),
            ),
          ],
        ),
      ];
}
