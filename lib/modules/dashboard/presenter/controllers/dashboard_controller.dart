
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';

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

  void carregaEmblemaDoadores() async {
    try {
      if (serviceRoute.permissions!.value >= LevelPermissoes.admin.value) {
        var ret = await emblemasRepository.listDocument(
          where: EmblemaParams(
            categoria: CategoriaEmblema.doacao.name,
            limit: 100,
          ),
        );
        emblemasDoadores.value = ret.data;
      }
    } catch (e) {
      Helps.log(e);
    }
  }

  Future<int> calculaTotalAdquirido(String idEmblema) async {
    var ret = await emblemaUserRepository.listDocument(
      where: EmblemaUserParams(idEmblema: idEmblema),
    );
    return ret.total;
  }
}
