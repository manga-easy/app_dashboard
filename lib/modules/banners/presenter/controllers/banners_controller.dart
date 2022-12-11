import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/repositories/banner_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class BannerController extends IController {
  final BannerRepository bannerRepository;
  final Global global;
  var listaBannerItens = <BannerModel>[];
  var status = ValueNotifier(StatusBuild.loading);

  BannerController({required this.bannerRepository, required this.global});

  @override
  void dispose() {
    super.dispose();
    status.dispose();
  }

  @override
  void init(BuildContext context) {
    listaBanner();
  }

  void listaBanner() async {
    status.value = StatusBuild.loading;
    try {
      var ret = await bannerRepository.listDocument();
      listaBannerItens = ret.data;
      status.value = StatusBuild.done;
    } catch (e) {
      status.value = StatusBuild.erro;
      Helps.log(e);
    }
  }

  Future<void> deleteBanner(BannerModel reco, context) async {
    try {
      await bannerRepository.deletDocument(id: reco.id!);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Banner deletada com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }
}
