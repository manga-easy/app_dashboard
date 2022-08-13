import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_repository.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/comic_controller.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_comic_controller.dart';

class AutorModule extends IModuleFactory {
  @override
  void register() {
    // Repositories
    di.registerFactory(() => ComicAuthorialRepository());
    // Controllers
    di.registerFactory(() => ComicAuthorialController(comicRepository: di()));
    di.registerFactory(
        () => EditComicAuthorialController(comicAuthorialRepository: di(), serviceRoute: di()));
  }
}
