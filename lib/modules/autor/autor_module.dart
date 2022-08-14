import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/chapter_authoral_repository.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/comic_repository.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/comic_controller.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_comic_controller.dart';

class AutorModule extends IModuleFactory {
  @override
  void register() {
    // Repositories
    di.registerFactory(() => ComicAuthorialRepository());
    di.registerFactory(() => ChapterAuthoralRepository());
    // Controllers
    di.registerFactory(() => ComicAuthorialController(comicRepository: di()));
    di.registerFactory(() => EditComicAuthorialController(
          comicAuthorialRepository: di(),
          serviceRoute: di(),
        ));
    di.registerFactory(() => EditChapterComicController(
          chapterAuthoralRepository: di(),
          comicAuthorialRepository: di(),
        ));
  }
}
