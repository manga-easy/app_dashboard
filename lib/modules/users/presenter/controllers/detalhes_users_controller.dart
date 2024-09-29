import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/emblemas/data/repositories/achievements_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/users/data/dtos/create_user_achievement_dto.dart';
import 'package:dashboard_manga_easy/modules/users/data/repositories/user_achievement_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user_achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class UsersDetalhesController extends ManagerStore {
  final UserAchievementRepository _userAchievementRepository;
  final AchievementsRepository _emblemasRepository;
  final UsersRepository _usersRepository;
  UsersDetalhesController(
    this._userAchievementRepository,
    this._emblemasRepository,
    this._usersRepository,
  );

  User? user;
  List<UserAchievement> emblemasUsers = [];

  @override
  Future<void> init(Map<String, dynamic> arguments) => handleTry(
        call: () async {
          final userId = arguments['id'];
          user = await _usersRepository.getDocument(id: userId);
          await loadAchievementsUser();
        },
      );

  Future<void> loadAchievementsUser() async {
    emblemasUsers = await _userAchievementRepository.listDocument(
      userId: user!.id!,
    );
  }

  Future<List<AchievementEntity>> loadAchievements(String search) {
    return _emblemasRepository.get();
  }

  Future<AchievementEntity?> getAchievement(String idAchievement) {
    return _emblemasRepository.getById(id: idAchievement);
  }

  Future<void> addEmblema(String achievementId) => handleTry(
        showDialogError: true,
        onCatch: StateManager.done,
        call: () async {
          await _userAchievementRepository.creatDocument(
            objeto: CreateUserAchievementDto(
              achievementId: achievementId,
              userId: user!.id!,
            ),
          );
          await loadAchievementsUser();
        },
      );

  Future<void> removerEmblema(
    String achievementId,
    BuildContext context,
  ) =>
      handleTry(
        onCatch: StateManager.done,
        showDialogError: true,
        call: () async {
          final ret = await AppHelps.confirmaDialog(
            title: 'Tem certeza?',
            content: '',
            context: context,
          );
          if (ret) {
            await _userAchievementRepository.deletDocument(
              achievementId: achievementId,
              userId: user!.id!,
            );
            await loadAchievementsUser();
          }
        },
      );
}
