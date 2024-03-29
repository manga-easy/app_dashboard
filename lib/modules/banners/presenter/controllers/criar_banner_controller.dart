import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/models/banner_model.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/repositories/banner_repository.dart';
import 'package:flutter/material.dart';

class CriarBannerController extends IController {
  final BannerRepository bannerRepository;
  BannerModel? banner;

  CriarBannerController({required this.bannerRepository});

  @override
  void init(BuildContext context) {
    banner = ModalRoute.of(context)!.settings.arguments as BannerModel?;
    banner ??= BannerModel.empty();
    notifyListeners();
  }

  Future<void> criarBanner(context) async {
    try {
      String tipo = 'criado';
      if (banner!.id == null) {
        await bannerRepository.creatDocument(objeto: banner!);
      } else {
        await bannerRepository.updateDocument(objeto: banner!);
        tipo = 'salvo';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Banner $tipo com sucesso',
        context: context,
      );
    } catch (e) {
      handlerError(e, context);
    }
  }
}
