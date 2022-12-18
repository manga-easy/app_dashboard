import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repository_external.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/create_temporada_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/list_temporada_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/usercases/update_temporada_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditTemporadasController extends ValueNotifier implements IController {
  final UserRepositoryExternal userRepo;
  final CreateTemporadaCase createTemporadaCase;
  final ListTemporadaCase listTemporadaCase;
  final UpdateTemporadaCase updateTemporadaCase;

  EditTemporadasController(
    super.value, {
    required this.createTemporadaCase,
    required this.userRepo,
    required this.listTemporadaCase,
    required this.updateTemporadaCase,
  });

  TemporadaModel? temporada;

  @override
  void init(BuildContext context) {
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
        var retTempo = await listTemporadaCase();
        temporada!.number = retTempo.length + 1;
        await createTemporadaCase(temporada: temporada!);
      } else {
        await updateTemporadaCase(temporada: temporada!);
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
