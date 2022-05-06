import 'package:dashboard_manga_easy/core/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/core/interfaces/module_service.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/main.dart';

class CoreModule extends IModuleService {
  @override
  void register() {
    //register factorys
    di.registerFactory(() => FCMApi());

    //register singletons
    di.registerLazySingleton(() => HiveDb());
    di.registerLazySingleton(() => AppwriteClient());
    di.registerLazySingleton(() => AppwriteAdmin());
    di.registerLazySingleton(() => Global());
  }

  @override
  Future<void> start() async {
    await di.get<HiveDb>().initialise();
    await di.get<AppwriteClient>().initialise();
    await di.get<AppwriteAdmin>().initialise();
    await di.get<Global>().initialise();
  }
}
