import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/info_comic_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/view_comic_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/mangas/infra/info_comic_repository.dart';
import 'package:dashboard_manga_easy/modules/mangas/infra/view_comic_repository.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';

class MangasModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory<IInforComicRepository>(() => InfoComicRepository(di()));
    di.registerFactory<IViewComicRepository>(() => ViewComicRepository(di()));
    //controllers
    di.registerFactory(() => MangasController(
          infoComicRepository: di(),
          global: di(),
          viewComicRepository: di(),
          configAppRepository: di(),
        ));
  }
}
