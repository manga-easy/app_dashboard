import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';

import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EmblemasController extends IController {
  final EmblemasRepository _emblemasRepository;
  EmblemasController(this._emblemasRepository);

  var lista = <Emblema>[];
  var pesquisa = '';
  var status = ValueNotifier(StatusBuild.loading);

  @override
  void dispose() {
    super.dispose();
    status.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaEmblemas();
  }

  Future<void> carregaEmblemas() async {
    try {
      status.value = StatusBuild.loading;
      lista = await _emblemasRepository.listDocument(where: EmblemaParams());

      status.value = StatusBuild.done;
    } on Exception catch (e) {
      status.value = StatusBuild.erro;
      Helps.log(e);
    }
  }
}
