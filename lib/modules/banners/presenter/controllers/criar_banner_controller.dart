import 'package:dashboard_manga_easy/modules/banners/data/dtos/create_banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/events/details_banner_event.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class CriarBannerController extends ManagerStore<DetailsBannerEvent> {
  final BannerRepository bannerRepository;

  CreateBannerDto dto = CreateBannerDto.empty();

  CriarBannerController({required this.bannerRepository});
  String? id;
  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    if (arguments['id'] != 'create') {
      id = arguments['id'];
      final banners = await bannerRepository.getById(id!);
      dto = CreateBannerDto.fromEntity(banners!);
    }
    state = StateManager.done;
  }

  void criarBanner() => handleTry(
        call: () async {
          String tipo = 'criado';
          if (id == null) {
            await bannerRepository.creatDocument(dto: dto);
          } else {
            await bannerRepository.updateDocument(dto: dto, id: id!);
            tipo = 'salvo';
          }
          emitNavigation(DetailsBannerEventSuccess(tipo));
        },
      );

  Future<void> pickerImage(context) => handleTry(
        call: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile == null) {
            throw Exception('Erro ao selecionar imagem');
          }

          await bannerRepository.updateImage(
            file: pickedFile,
            id: id!,
          );
          Navigator.of(context).pop();
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );
}
