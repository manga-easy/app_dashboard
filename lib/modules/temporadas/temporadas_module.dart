import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/edit_temporada_controller.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/temporadas_controller.dart';

class TemporadasModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => TemporadasRepository(di()));
    //register controllers
    di.registerFactory(() => TemporadasController(temporadasRepository: di()));
    di.registerFactory(
      () => EditTemporadasController(
        temporadasRepository: di(),
        userRepo: di(),
      ),
    );
  }
}
