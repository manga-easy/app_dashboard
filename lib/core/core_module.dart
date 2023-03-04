import 'package:dashboard_manga_easy/core/interfaces/local_data_interface.dart';
import 'package:dashboard_manga_easy/core/interfaces/module_service.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/hive_service.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';

class CoreModule extends IModuleService {
  @override
  void register() {
    //register singletons
    di.registerLazySingleton<ILocalData>(() => HiveDb());
    di.registerLazySingleton(() => AppwriteClient());
    di.registerLazySingleton(() => AppwriteAdmin());
    di.registerLazySingleton(() => ServiceRoute());
  }

  @override
  Future<void> start() async {
    await di.get<ILocalData>().initialise();
    await di.get<AppwriteClient>().initialise();
    await di.get<AppwriteAdmin>().initialise();
    await di.get<ServiceRoute>().initialise();
  }
}
