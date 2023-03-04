import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/usecases/create_emblema_case.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/usecases/update_emblema_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CriaEditaEmblemaController extends  IController {
  final CreateEmblemaCase createEmblemaCase;
  final UpdateEmblemaCase updateEmblemaCase;

  CriaEditaEmblemaController(
    {
    required this.createEmblemaCase,
    required this.updateEmblemaCase,
  });

  Emblema? emblema;

  @override
  void init(BuildContext context) {
    emblema = ModalRoute.of(context)!.settings.arguments as Emblema?;
    emblema ??= Emblema.empty();
    notifyListeners();
  }

  void criaAlteraEmblema(context) async {
    try {
      if (emblema!.benefits.isEmpty) {
        throw Exception('Benefícios não pode ta vazio');
      }
      if (emblema!.id == null) {
        await createEmblemaCase(emblema: emblema!);
      } else {
        await updateEmblemaCase(emblema: emblema!);
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Emblema salvo com sucesso',
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
    notifyListeners();
  }

  void update() => notifyListeners();
}
