import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/banners_controller.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/criar_banner_controller.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:go_router/go_router.dart';

class BannersModule implements Module {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => BannerRepositoryV2(di()));
    //register controllers
    di.registerFactory(
      () => CriarBannerController(
        bannerRepository: di(),
      ),
    );
    di.registerFactory(
      () => BannerController(
        bannerRepository: di(),
      ),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: BannerPage.route,
          builder: (context, state) => const BannerPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                state.pathParameters;
                return const CriarBannerPage();
              },
            ),
          ],
        ),
      ];
}
