import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';
import 'package:flutter/material.dart';

class BannerController extends IController {
  final BannerRepositoryV2 bannerRepository;
  var listaBannerItens = <BannerEntity>[];
  BannerController({required this.bannerRepository});

  @override
  void init(BuildContext context) {
    listaBanner();
  }

  Future<void> listaBanner() async {
    state = StatusBuild.loading;
    try {
      listaBannerItens = await bannerRepository.listDocument();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
      Helps.log(e);
    }
  }

  Future<void> deleteBanner(String id, context) async {
    try {
      await bannerRepository.deletDocument(id: id);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Banner deletada com sucesso',
        context: context,
      );
    } catch (e) {
      handlerError(e, context);
    }
  }
}
