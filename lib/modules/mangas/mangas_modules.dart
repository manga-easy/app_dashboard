import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/datasources/manga_datasource.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/datasources/manga_datasource_v1.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/repositories/manga_repository_imp.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/mappers/mapper_manga.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/details_manga_controller.dart';

class MangasModule extends IModuleFactory {
  @override
  void register() {
    //mappers
    di.registerFactory<MangaMapper>(() => MangaMapper());
    //datasources
    di.registerFactory<MangaDatasource>(() => MangaDatasourceV1(di(), di()));
    //repositories
    di.registerFactory<MangaRepository>(() => MangaRepositoryImp(di(), di()));
    //controllers
    di.registerFactory(() => DetailsMangaController(di()));
  }
}
