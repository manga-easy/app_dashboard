import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/achievements_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_params.dart';
import 'package:page_manager/manager_store.dart';

class EmblemasController extends ManagerStore {
  final AchievementsRepository _emblemasRepository;
  EmblemasController(this._emblemasRepository);

  var lista = <AchievementEntity>[];
  String get search => _search;
  var _search = '';
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  @override
  void init(Map<String, dynamic> arguments) {
    carregaEmblemas();
  }

  Future<void> carregaEmblemas() => handleTry(
        call: () async {
          lista = await _emblemasRepository.get(where: AchievementParams());
        },
        onWhenRethow: (e) => false,
      );
}
