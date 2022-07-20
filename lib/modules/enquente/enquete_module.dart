import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';

class EnqueteModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => EnqueteRepository(di()));
    //register controllers
    di.registerFactory(() => EnqueteController(appwriteAdmin: di(), permissoesRepository: di()));
    di.registerFactory(
        () => EditEnqueteController(appwriteAdmin: di(), permissoesRepository: di(), userRepo: di()));
  }
}
