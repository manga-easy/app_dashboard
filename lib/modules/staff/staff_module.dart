import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/staff_controller.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/repositories/staff_repository.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/ui/pages/edit_staff_page.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/ui/pages/staff_page.dart';
import 'package:go_router/go_router.dart';

class StaffModule implements Module {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => StaffRepository(di()));
    //register controller
    di.registerFactory(
      () => StaffController(
        di(),
        di(),
      ),
    );
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: StaffPage.route,
          builder: (context, state) => const StaffPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const EditStaffPage(),
            ),
          ],
        ),
      ];
}
