import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repository_external.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EditTemporadasController extends ValueNotifier implements IController {
  final UserRepositoryExternal userRepo;
  final TemporadasRepository temporadasRepository;
  TemporadaModel? temporada;
  EditTemporadasController({
    required this.temporadasRepository,
    required this.userRepo,
  }) : super(null);

  @override
  void onClose() {
    dispose();
  }

  @override
  void onInit(BuildContext context) {
    temporada = ModalRoute.of(context)!.settings.arguments as TemporadaModel?;
    temporada ??= TemporadaModel(
      id: null,
      nome: '',
      datafim: null,
      datainit: DateTime.now().millisecondsSinceEpoch,
      number: 0,
    );
    notifyListeners();
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
      var op = 'criado';
      if (temporada!.id == null) {
        var retTempo = await temporadasRepository.listDocument();
        temporada!.number = retTempo.total + 1;
        await temporadasRepository.creatDocument(objeto: temporada!);
      } else {
        await temporadasRepository.updateDocument(objeto: temporada!);
        op = 'atualizado';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Temporada $op com sucesso',
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
