import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class TemporadasController extends IController {
  final TemporadasRepository temporadasRepository;
  var status = ValueNotifier(StatusBuild.loading);
  var temporadas = <TemporadaModel>[];
  TemporadasController({
    required this.temporadasRepository,
  });

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
    var ret = await temporadasRepository.listDocument();
    temporadas = ret.data;
    status.value = StatusBuild.done;
  }

  Future<void> removeTemporadas(String id, context) async {
    var ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: 'removerá a temporda',
      context: context,
    );
    if (ret) {
      await temporadasRepository.deletDocument(id: id);
      carregaTemporadas();
    }
  }
}
