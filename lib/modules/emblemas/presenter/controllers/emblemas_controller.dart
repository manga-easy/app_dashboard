import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';

import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';

class EmblemasController extends IController {
  final EmblemasRepository _emblemasRepository;
  EmblemasController(this._emblemasRepository);

  var lista = <Emblema>[];
  var pesquisa = '';

  @override
  void init(BuildContext context) {
    carregaEmblemas();
  }

  Future<void> carregaEmblemas() async {
    try {
      state = StatusBuild.loading;
      lista = await _emblemasRepository.listDocument(where: EmblemaParams());

      state = StatusBuild.done;
    } on Exception catch (e) {
      state = StatusBuild.erro;
      handleErrorEvent(e);
    }
  }
}
