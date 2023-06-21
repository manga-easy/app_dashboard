import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/core/interfaces/local_data_interface.dart';
import 'package:dashboard_manga_easy/core/interfaces/module_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_appwrite_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';

class CoreModule extends IModuleService {
  @override
  void register() {
    //register singletons
    di.registerLazySingleton<ClientRequest>(() => ClientHttp());
    di.registerLazySingleton<ILocalData>(() => HiveDb());
    di.registerLazySingleton(() => ServiceRoute());
    di.registerLazySingleton<AuthService>(() => AuthAppwriteService());
  }

  @override
  Future<void> start() async {
    await di.get<ILocalData>().initialise();
    await di.get<AuthService>().initialization();
    await di.get<ServiceRoute>().initialise();
  }
}
