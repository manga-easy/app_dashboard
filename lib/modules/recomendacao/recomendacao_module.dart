import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/repositories/recommendation_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';

class RecomendacaoModule extends IModuleFactory {
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
}
