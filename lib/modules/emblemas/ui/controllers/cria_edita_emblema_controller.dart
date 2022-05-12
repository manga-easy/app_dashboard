import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriaEditaEmblemaController extends ValueNotifier implements IController {
  final AppwriteAdmin app;
  Emblema? emblema;
  CriaEditaEmblemaController({required this.app}) : super(null);

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
      percent: 0.0,
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
      if (emblema!.id == null) {
        await app.database.createDocument(
          collectionId: Emblema.collectionId,
          documentId: 'unique()',
          data: emblema!.toJson(),
          read: ['role:all'],
          write: ['role:all'],
        );
      } else {
        await app.database.updateDocument(
          collectionId: Emblema.collectionId,
          documentId: emblema!.id!,
          data: emblema!.toJson(),
        );
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Emblema salvo com sucesso',
        context: context,
      );
    } catch (e) {
      Helps.log(e);
    }
    notifyListeners();
  }
}
