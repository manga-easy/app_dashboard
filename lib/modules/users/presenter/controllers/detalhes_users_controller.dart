import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/users/data/dtos/create_user_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/user_achievement_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user_achievement_entity.dart';
import 'package:flutter/material.dart';

class UsersDetalhesController extends IController {
  final UserAchievementRepository _userAchievementRepository;
  final EmblemasRepository _emblemasRepository;
  UsersDetalhesController(
    this._userAchievementRepository,
    this._emblemasRepository,
  );

  User? user;
  List<UserAchievement> emblemasUsers = [];

  @override
  Future<void> init(BuildContext context) async {
    try {
      user = ModalRoute.of(context)!.settings.arguments as User;
      await loadAchievementsUser();
      state = StatusBuild.done;
    } on Exception catch (e) {
      handleErrorEvent(e);
      state = StatusBuild.erro;
    }
  }

  Future<void> loadAchievementsUser() async {
    emblemasUsers = await _userAchievementRepository.listDocument(
      userId: user!.id!,
    );
  }

  Future<List<Emblema>> loadAchievements(String search) {
    return _emblemasRepository.listDocument();
  }

  Future<Emblema?> getAchievement(String idAchievement) {
    return _emblemasRepository.getDocument(id: idAchievement);
  }

  Future<void> addEmblema(String achievementId) async {
    try {
      state = StatusBuild.loading;
      await _userAchievementRepository.creatDocument(
        objeto: CreateUserAchievementDto(
          achievementId: achievementId,
          userId: user!.id!,
        ),
      );
      await loadAchievementsUser();
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }

  Future<void> removerEmblema(
    String achievementId,
    BuildContext context,
  ) async {
    try {
      final ret = await AppHelps.confirmaDialog(
        title: 'Tem certeza?',
        content: '',
        context: context,
      );
      if (ret) {
        state = StatusBuild.loading;
        await _userAchievementRepository.deletDocument(
          achievementId: achievementId,
          userId: user!.id!,
        );
        await loadAchievementsUser();
      }
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }
}
