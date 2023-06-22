import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/datasources/permissions_datasource.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/datasources/permissions_datasource_v1.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/repositories/permissions_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';

class PermissoesModule extends IModuleFactory {
  @override
  void register() {
    // datasources
    di.registerFactory<PermissionsDatasource>(
      () => PermissionsDatasourceV1(di(), di()),
    );
    //register repositories
    di.registerFactory<PermissionsRepository>(
      () => PermissionsRepositoryV1(di()),
    );
    //register controllers
    di.registerFactory(() => PermissoesController(di()));
    di.registerFactory(() => EditPermissoesController(di()));
  }
}
