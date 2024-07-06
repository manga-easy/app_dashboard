import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/repositories/manga_repository_imp.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/mappers/mapper_manga.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/details_manga_controller.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/details_manga_page.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/mangas_pages.dart';
import 'package:go_router/go_router.dart';

class MangasModule implements Module {
  @override
  void register() {
    //mappers
    di.registerFactory<MangaMapper>(() => MangaMapper());
    //repositories
    di.registerFactory<MangaRepository>(() => MangaRepositoryImp(di(), di()));
    //controllers
    di.registerFactory(() => DetailsMangaController(di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: MangasPage.route,
          builder: (context, state) => const MangasPage(),
        ),
        GoRoute(
          path: DetailsMangaPage.route,
          builder: (context, state) => const DetailsMangaPage(),
        ),
      ];
}
