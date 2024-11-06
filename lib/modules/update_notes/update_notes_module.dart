import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/update_notes/data/repositories/update_notes_repository.dart';
import 'package:dashboard_manga_easy/modules/update_notes/presenter/controllers/update_notes_controller.dart';
import 'package:dashboard_manga_easy/modules/update_notes/presenter/ui/create_update_notes_page.dart';
import 'package:dashboard_manga_easy/modules/update_notes/presenter/ui/release_notes_page.dart';
import 'package:go_router/go_router.dart';

class UpdateNotesModule implements Module {
  @override
  void register() {
    //Register Repository
    di.registerFactory(() => UpdateNotesRepository(di()));
    //Register Controller
    di.registerFactory(() => UpdateNotesController(di()));
  }

  @override
  List<RouteBase> routes() => [
        GoRoute(
          path: ReleaseNotesPage.route,
          builder: (context, state) => const ReleaseNotesPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                return const CreateUpdateNotesPage();
              },
            ),
            GoRoute(
              path: 'create',
              builder: (context, state) {
                return const CreateUpdateNotesPage();
              },
            ),
          ],
        ),
      ];
}
