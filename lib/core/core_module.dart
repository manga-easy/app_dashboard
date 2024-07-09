import 'package:dashboard_manga_easy/core/libraries/templates/handle_dialog_error.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/handle_when_get_rethrow.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_response_parse.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_appwrite_service.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:page_manager/handles/manager_handle_dialog_error.dart';
import 'package:page_manager/handles/manager_handle_when_get_rethrow.dart';

class CoreModule {
  void register() {
    di.registerFactory<ManagerHandleDialogError>(
      () => HandleDialogError(),
    );
    di.registerFactory<ManagerHandleWhenGetRethrow>(
      () => HandleWhenGetRethrow(),
    );
    //register singletons
    di.registerLazySingleton<PersistentDatabaseSembast>(
      () => PersistentDatabaseSembast(),
    );
    di.registerFactory(() => ApiResponseParser());
    di.registerFactory(() => ApiMonolith(di()));
    di.registerLazySingleton(() => ServiceRoute());
    di.registerLazySingleton<AuthService>(() => AuthAppwriteService());
  }

  Future<void> start() async {
    await di.get<PersistentDatabaseSembast>().starting();
    await di.get<AuthService>().initialization();
    await di.get<ServiceRoute>().initialise();
  }
}
