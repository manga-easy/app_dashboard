import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriarBannerController extends ValueNotifier implements IController {
  final AppwriteClient app;
  final Global global;
  BannerModel? banner;
  CriarBannerController({
    required this.app,
    required this.global,
  }) : super(null);

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    banner = ModalRoute.of(context)!.settings.arguments as BannerModel?;
    banner ??= BannerModel(
      image: '',
      link: '',
      type: 'parceiro',
    );
    notifyListeners();
  }

  void criarBanner(context) async {
    try {
      String tipo = 'criado';
      if (banner!.id == null) {
        await app.database.createDocument(
          collectionId: BannerModel.collectionID,
          documentId: 'unique()',
          data: banner!.toJson(),
          read: ['role:all'],
          write: ['role:all'],
        );
      } else {
        await app.database.updateDocument(
          collectionId: BannerModel.collectionID,
          documentId: banner!.id!,
          data: banner!.toJson(),
        );
        tipo = 'salvo';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Banner $tipo com sucesso',
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
