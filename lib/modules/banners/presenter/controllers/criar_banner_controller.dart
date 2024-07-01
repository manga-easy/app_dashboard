import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/banners/data/dtos/create_banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';
import 'package:flutter/material.dart';

class CriarBannerController extends IController {
  final BannerRepositoryV2 bannerRepository;
  BannerEntity? banner;
  CreateBannerDto dto = CreateBannerDto.empty();

  CriarBannerController({required this.bannerRepository});

  @override
  void init(BuildContext context) {
    banner = ModalRoute.of(context)!.settings.arguments as BannerEntity?;
    if (banner != null) {
      dto = CreateBannerDto.fromEntity(banner!);
    }
    notifyListeners();
  }

  Future<void> criarBanner(context) async {
    try {
      String tipo = 'criado';
      if (banner == null) {
        await bannerRepository.creatDocument(dto: dto);
      } else {
        await bannerRepository.updateDocument(dto: dto, id: banner!.id);
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
