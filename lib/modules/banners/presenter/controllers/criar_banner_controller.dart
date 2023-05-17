import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/repositories/banner_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CriarBannerController extends IController {
  final BannerRepository bannerRepository;
  BannerModel? banner;

  CriarBannerController({required this.bannerRepository});

  @override
  void init(BuildContext context) {
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
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
  }
}
