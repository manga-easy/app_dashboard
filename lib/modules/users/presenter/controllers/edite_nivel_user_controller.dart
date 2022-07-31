import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/permissoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EditeNivelUserController extends ValueNotifier implements IController {
  final NivelUserRepository nivelUserRepository;

  NivelUser? nivelUser;
  EditeNivelUserController({required this.nivelUserRepository}) : super(null);

  @override
  void onClose() {
    dispose();
  }

  @override
  void onInit(BuildContext context) {
    nivelUser = ModalRoute.of(context)!.settings.arguments as NivelUser;
    notifyListeners();
  }

  void salvarNivel(BuildContext context) async {
    try {
      var op = 'criado';
      if (nivelUser!.id == null) {
        await nivelUserRepository.creatDocument(objeto: nivelUser!);
      } else {
        await nivelUserRepository.updateDocument(objeto: nivelUser!);
        op = 'atualizado';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Nível $op com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
  }
}
