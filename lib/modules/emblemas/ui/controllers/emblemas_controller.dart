import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasController implements IController {
  var lista = <Emblema>[];
  final EmblemasRepository emblemasRepository;

  var pesquisa = '';
  var status = ValueNotifier(StatusBuild.loading);
  EmblemasController({required this.emblemasRepository});

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    carregaEmblemas();
  }

  void carregaEmblemas() async {
    status.value = StatusBuild.loading;
    var ret = await emblemasRepository.listDocument(where: EmblemaParams());
    lista = ret.data;
    status.value = StatusBuild.done;
  }
}
