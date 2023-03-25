import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';

import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/usecases/list_emblema_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EmblemasController extends IController {
  var lista = <Emblema>[];
  final ListEmblemasCase listEmblemasCase;

  var pesquisa = '';
  var status = ValueNotifier(StatusBuild.loading);
  EmblemasController(this.listEmblemasCase);

  @override
  void dispose() {
    super.dispose();
    status.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaEmblemas();
  }

  void carregaEmblemas() async {
    status.value = StatusBuild.loading;
    var ret = await listEmblemasCase(where: EmblemaParams());
    lista = ret;
    status.value = StatusBuild.done;
  }
}
