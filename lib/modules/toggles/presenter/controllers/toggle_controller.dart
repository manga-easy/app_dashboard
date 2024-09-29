import 'package:dashboard_manga_easy/modules/toggles/data/repositories/toggle_repository.dart';
import 'package:dashboard_manga_easy/modules/toggles/domain/entities/toggle_entity.dart';
import 'package:page_manager/manager_store.dart';

class ToggleController extends ManagerStore<bool> {
  final ToggleRepositoryV1 _toggleRepository;
  var toggles = <ToggleEntity>[];
  ToggleController(this._toggleRepository);

  @override
  void init(Map<String, dynamic> arguments) {
    listToggles();
  }

  Future<void> listToggles() => handleTry(
        call: () async => toggles = await _toggleRepository.list(),
      );
}
