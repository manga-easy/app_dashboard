import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_controller.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_details_controller.dart';

class HostModule extends IModuleFactory {
  @override
  void register() {
    //repositories
    di.registerFactory<HostRepository>(() => HostRepositoryV1(di()));
    //controllers
    di.registerFactory(() => HostDetailsController(di()));

    di.registerFactory(() => HostController(di()));
  }
}
