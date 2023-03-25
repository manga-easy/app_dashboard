import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';

import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/list_temporada_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class TemporadasController extends IController {
  final ListTemporadaCase listTemporadaCase;
  TemporadasController({
    required this.listTemporadaCase,
  });
  var status = ValueNotifier(StatusBuild.loading);
  var temporadas = <TemporadaModel>[];

  @override
  void dispose() {
    super.dispose();
    status.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaTemporadas();
  }

  void carregaTemporadas() async {
    status.value = StatusBuild.loading;
    temporadas = await listTemporadaCase();
    status.value = StatusBuild.done;
  }
}
