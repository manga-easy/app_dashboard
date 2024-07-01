import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/user_achievement_repository.dart';
import 'package:flutter/material.dart';

class DashboardController extends IController {
  final ServiceRoute serviceRoute;
  final UserAchievementRepository userAchievementRepository;
  final EmblemasRepository emblemasRepository;
  var emblemasDoadores = ValueNotifier(<Emblema>[]);
  var status = ValueNotifier(StatusBuild.done);

  DashboardController({
    required this.serviceRoute,
    required this.userAchievementRepository,
    required this.emblemasRepository,
  });

  @override
  void dispose() {
    super.dispose();
    status.dispose();
    emblemasDoadores.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaEmblemaDoadores();
  }

  Future<void> carregaEmblemaDoadores() async {
    try {
      emblemasDoadores.value = await emblemasRepository.listDocument(
        where: EmblemaParams(
          categoria: CategoriaEmblema.doacao.name,
        ),
      );
    } catch (e) {
      Helps.log(e);
    }
  }
}
