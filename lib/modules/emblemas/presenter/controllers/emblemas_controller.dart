import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EmblemasController extends IController {
  var lista = <Emblema>[];
  final EmblemasRepository emblemasRepository;

  var pesquisa = '';
  var status = ValueNotifier(StatusBuild.loading);
  EmblemasController(this.emblemasRepository);

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
    var ret = await emblemasRepository.listDocument(where: EmblemaParams());
    lista = ret.data;
    status.value = StatusBuild.done;
  }
}
