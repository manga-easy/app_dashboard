import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:page_manager/manager_store.dart';

class SplashController extends ManagerStore<String> {
  @override
  void init(Map<String, dynamic> arguments) {
    loadingServices();
  }

  Future<void> loadingServices() => handleTry(
        call: () async {
          await CoreModule().start();
          emitNavigation(AuthPage.route);
        },
      );
}
