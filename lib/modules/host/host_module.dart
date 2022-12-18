import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/create_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/delete_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/list_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/update_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/external/host_datasource_imp.dart';
import 'package:dashboard_manga_easy/modules/host/infra/datasources/host_datasources.dart';
import 'package:dashboard_manga_easy/modules/host/infra/repositories/host_repository_imp.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_controller.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_details_controller.dart';

class HostModule extends IModuleFactory {
  @override
  void register() {
    //datasources
    di.registerFactory<HostDatasource>(() => HostDataSourceAppwrite(di()));
    //repositories
    di.registerFactory<HostRepository>(() => HostRepositoryImp(di()));
    //usecase
    di.registerFactory(() => ListHostCase(di()));
    di.registerFactory(() => CreateHostCase(di()));
    di.registerFactory(() => UpdateHostCase(di()));
    di.registerFactory(() => DeleteHostCase(di()));
    //controllers
    di.registerFactory(() => HostDetailsController(
          createHostCase: di(),
          updateHostCase: di(),
        ));

    di.registerFactory(() => HostController(
          listHostCase: di(),
          deleteHostCase: di(),
          updateHostCase: di(),
        ));
  }
}
