import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/enquente/domain/repositories/enquete_repository.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/controllers/edit_enquete_controller.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/controllers/enquete_controller.dart';

class EnqueteModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => EnqueteRepository(di()));
    //register controllers
    di.registerFactory(() => EnqueteController(permissoesRepository: di()));
    di.registerFactory(() => EditEnqueteController(permissoesRepository: di(), userRepo: di()));
  }
}
