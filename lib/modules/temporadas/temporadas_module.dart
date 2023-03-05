import 'package:dashboard_manga_easy/core/interfaces/module_factory.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/create_temporada_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/list_temporada_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/update_temporada_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/edit_temporada_controller.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/temporadas_controller.dart';

class TemporadasModule extends IModuleFactory {
  @override
  void register() {
    //register repositories
    di.registerFactory(() => TemporadasRepository(di()));
    //register usercases
    di.registerFactory<CreateTemporadaCase>(
      () => CreateTemporadaCaseImpl(di(), di(), di()),
    );
    di.registerFactory<ListTemporadaCase>(
      () => ListTemporadaCaseImpl(di()),
    );
    di.registerFactory<UpdateTemporadaCase>(
      () => UpdateTemporadaCaseImpl(di(), di(), di()),
    );
    //register controllers
    di.registerFactory(() => TemporadasController(listTemporadaCase: di()));
    di.registerFactory(
      () => EditTemporadasController(
        userRepo: di(),
        createTemporadaCase: di(),
        listTemporadaCase: di(),
        updateTemporadaCase: di(),
      ),
    );
  }
}
