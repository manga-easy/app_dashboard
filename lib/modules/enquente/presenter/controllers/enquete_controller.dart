import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/enquente/domain/repositories/enquete_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EnqueteController extends IController {
  final EnqueteRepository permissoesRepository;
  var status = ValueNotifier(StatusBuild.loading);
  var enquetes = <EnqueteModel>[];
  EnqueteController({
    required this.permissoesRepository,
  });

  @override
  void onClose() {
    status.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaEnquete();
  }

  void carregaEnquete() async {
    status.value = StatusBuild.loading;
    var ret = await permissoesRepository.listDocument();
    enquetes = ret.data;
    status.value = StatusBuild.done;
  }

  Future<void> removeEnquete(String id, context) async {
    var ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: 'removerá a enquete',
      context: context,
    );
    if (ret) {
      await permissoesRepository.deletDocument(id: id);
      carregaEnquete();
    }
  }
}
