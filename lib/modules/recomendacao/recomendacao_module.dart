import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/repositories/recommendation_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:go_router/go_router.dart';

class RecomendacaoModule implements Module {
  @override
  void register() {
    //register repositories
    di.registerFactory<RecommendationsRepository>(
      () => RecommendationsRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(() => CriarRecomendacaoController(di(), di()));
    di.registerFactory(() => RecomendacaoController(di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: RecomendacaoPage.route,
          builder: (context, state) => const RecomendacaoPage(),
        ),
        GoRoute(
          path: CriarRecomendacaoPage.route,
          builder: (context, state) => const CriarRecomendacaoPage(),
        ),
      ];
}
