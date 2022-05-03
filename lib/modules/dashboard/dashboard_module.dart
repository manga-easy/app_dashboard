import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardModule extends IModuleFactory {
  @override
  void register() {
    //register controllers
    di.registerFactory(() => DashboardController(global: di()));
  }
}
