import 'dart:io';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/dtos/create_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/achievements_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class CriaEditaEmblemaController extends ManagerStore {
  final AchievementsRepository _achievementRepository;

  CriaEditaEmblemaController(this._achievementRepository);

  String? achievementId;
  CreateAchievementDto dto = CreateAchievementDto.empty();
  File? image;

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    achievementId = arguments['achievementId'];
    if (achievementId != null) {
      final result = await _achievementRepository.getById(id: achievementId!);
      dto = CreateAchievementDto.fromEntity(result!);
    }
    state = StateManager.done;
  }

  Future<void> criaAlteraEmblema(context) async {
    if (achievementId == null) {
      await _achievementRepository.create(dto: dto);
    } else {
      await _achievementRepository.update(
        dto: dto,
        id: achievementId!,
      );
    }
    Navigator.of(context).pop();
    AppHelps.confirmaDialog(
      title: 'Sucesso',
      content: 'Emblema salvo com sucesso',
      context: context,
    );
  }

  Future<void> pickerImage(context) => handleTry(
        call: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile == null) {
            throw Exception('Erro ao selecionar imagem');
          }
          image = File(pickedFile.path);
          await _achievementRepository.updateImage(
            file: image!,
            id: achievementId!,
          );
          Navigator.of(context).pop();
        },
      );
}
