import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';

class DashboardController extends IController {
  final ServiceRoute serviceRoute;
  final EmblemaUserRepository emblemaUserRepository;
  final EmblemasRepository emblemasRepository;
  var emblemasDoadores = ValueNotifier(<Emblema>[]);
  var status = ValueNotifier(StatusBuild.done);

  DashboardController({
    required this.serviceRoute,
    required this.emblemaUserRepository,
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

  Future<int> calculaTotalAdquirido(String idEmblema) async {
    final ret = await emblemaUserRepository.listDocument(
      where: EmblemaUserParams(idEmblema: idEmblema, userId: ''),
    );
    return ret.length;
  }
}
