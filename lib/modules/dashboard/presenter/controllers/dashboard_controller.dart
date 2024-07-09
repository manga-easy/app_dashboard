import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/achievements_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_category.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_params.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/user_achievement_repository.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class DashboardController extends ManagerStore {
  final ServiceRoute serviceRoute;
  final UserAchievementRepository userAchievementRepository;
  final AchievementsRepository emblemasRepository;
  var emblemasDoadores = <AchievementEntity>[];

  DashboardController({
    required this.serviceRoute,
    required this.userAchievementRepository,
    required this.emblemasRepository,
  });

  @override
  void init(Map<String, dynamic> arguments) {
    carregaEmblemaDoadores();
  }

  Future<void> carregaEmblemaDoadores() async {
    try {
      state = StateManager.loading;
      emblemasDoadores = await emblemasRepository.get(
        where: AchievementParams(
          categoria: AchievementCategory.doacao.name,
        ),
      );
      state = StateManager.done;
    } catch (e) {
      Helps.log(e);
    }
  }
}
