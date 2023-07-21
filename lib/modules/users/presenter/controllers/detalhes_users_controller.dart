import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/levels_user_filter.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/levels_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UsersDetalhesController extends IController {
  final EmblemaUserRepository _emblemaUserRepository;
  final LevelsUserRepository _levelsUserRepository;
  final EmblemasRepository _emblemasRepository;
  UsersDetalhesController(
    this._emblemaUserRepository,
    this._levelsUserRepository,
    this._emblemasRepository,
  );

  User? user;
  List<EmblemaUser> emblemasUsers = [];
  var listXps = ValueNotifier(<NivelUser>[]);

  @override
  Future<void> init(BuildContext context) async {
    try {
      user = ModalRoute.of(context)!.settings.arguments as User;
      await carregaXpsUser();
      await loadAchievementsUser();
      state = StatusBuild.done;
    } on Exception catch (e) {
      handleErrorEvent(e);
      state = StatusBuild.erro;
    }
  }

  Future<void> loadAchievementsUser() async {
    emblemasUsers = await _emblemaUserRepository.listDocument(
      where: EmblemaUserParams(userId: user!.id!),
    );
  }

  Future<List<Emblema>> loadAchievements(String search) {
    return _emblemasRepository.listDocument();
  }

  Future<Emblema?> getAchievement(String idAchievement) {
    return _emblemasRepository.getDocument(id: idAchievement);
  }

  Future<void> addEmblema(String idEmblema) async {
    try {
      state = StatusBuild.loading;
      final embUser = EmblemaUser(
        timeCria: DateTime.now().millisecondsSinceEpoch,
        userId: user!.id!,
        idEmblema: idEmblema,
        createAt: 0,
        updateAt: 0,
      );
      await _emblemaUserRepository.creatDocument(objeto: embUser);
      await loadAchievementsUser();
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }

  Future<void> carregaXpsUser() async {
    listXps.value = await _levelsUserRepository.listDocument(
      where: LevelsUserFilter(userId: user!.id!),
    );
  }

  Future<void> removerEmblema(String idEmblema, BuildContext context) async {
    try {
      final ret = await AppHelps.confirmaDialog(
        title: 'Tem certeza?',
        content: '',
        context: context,
      );
      if (ret) {
        state = StatusBuild.loading;
        await _emblemaUserRepository.deletDocument(
          idEmblema: idEmblema,
          userID: user!.id!,
        );
        await loadAchievementsUser();
      }
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }
}
