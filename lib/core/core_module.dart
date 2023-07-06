import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/core/interfaces/module_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_appwrite_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CoreModule extends IModuleService {
  @override
  void register() {
    //register singletons
    di.registerFactory<ClientRequest>(() => ClientHttp());
    di.registerFactory(() => ApiResponseParser());
    di.registerLazySingleton<HiveDb>(() => HiveDb());
    di.registerLazySingleton(() => ServiceRoute());
    di.registerLazySingleton<AuthService>(() => AuthAppwriteService());
  }

  @override
  Future<void> start() async {
    await di.get<HiveDb>().initialise();
    await di.get<AuthService>().initialization();
    await di.get<ServiceRoute>().initialise();
  }
}
