import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriaEditaEmblemaController extends ValueNotifier implements IController {
  final EmblemasRepository emblemasRepository;
  Emblema? emblema;
  CriaEditaEmblemaController({required this.emblemasRepository}) : super(null);

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    emblema = ModalRoute.of(context)!.settings.arguments as Emblema?;
    emblema ??= Emblema(
      name: '',
      timeCria: DateTime.now().millisecondsSinceEpoch,
      rarity: RarityEmblema.comum,
      description: '',
      percent: 0.1,
      url: '',
      benefits: [],
      adsOff: false,
      disponivel: false,
      type: TypeEmblema.link.name,
      categoria: CategoriaEmblema.evento.name,
    );
    notifyListeners();
  }

  void criaAlteraEmblema(context) async {
    try {
      if (emblema!.benefits.isEmpty) {
        throw Exception('Benefícios não pode ta vazio');
      }
      if (emblema!.id == null) {
        await emblemasRepository.creatDocument(objeto: emblema!);
      } else {
        await emblemasRepository.updateDocument(objeto: emblema!);
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
