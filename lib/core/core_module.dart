import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/core/interfaces/module_service.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_appwrite_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:manga_easy_crashlytics_service/manga_easy_crashlytics_service.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:persistent_database/persistent_database.dart';

class CoreModule extends IModuleService {
  @override
  void register() {
    //register singletons
    di.registerLazySingleton<CrashlyticsService>(
      () => CrashlyticsGoogleService(),
    );
    di.registerLazySingleton<PersistentDatabaseSembast>(
      () => PersistentDatabaseSembast(),
    );
    di.registerLazySingleton<Preference>(() => Preference(di()));
    di.registerFactory(() => ApiResponseParser());
    di.registerFactory<ClientRequest>(() => ClientHttp());
    di.registerFactory(() => ApiMonolito(di(), di()));
    di.registerLazySingleton<HiveDb>(() => HiveDb());
    di.registerLazySingleton(() => ServiceRoute());
    di.registerLazySingleton<AuthService>(() => AuthAppwriteService());
  }

  @override
  Future<void> start() async {
    await di.get<HiveDb>().initialise();
    await di.get<PersistentDatabaseSembast>().starting();
    await di.get<AuthService>().initialization();
    await di.get<ServiceRoute>().initialise();
  }
}
