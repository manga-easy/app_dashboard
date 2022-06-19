import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';

class MangasModule extends IModuleFactory {
  @override
  void register() {
    di.registerFactory(() => MangasController(appwriteAdmin: di(), global: di()));
  }
}
