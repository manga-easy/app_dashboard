import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
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
  List<Emblema> listEmblema = [];
  var listXps = ValueNotifier(<NivelUser>[]);
  var indexP = ValueNotifier(0);

  @override
  void dispose() {
    super.dispose();
    indexP.dispose();
  }

  @override
  Future<void> init(BuildContext context) async {
    user = ModalRoute.of(context)!.settings.arguments as User;
    carregaXpsUser();
    await loadAchievementsUser();
    state = StatusBuild.done;
  }

  Future<void> loadAchievementsUser() async {
    emblemasUsers = await _emblemaUserRepository.listDocument(
      where: EmblemaUserParams(userId: user!.id!),
    );
  }

  Future<List<Emblema>> loadAchievements(String search) {
    return _emblemasRepository.listDocument(where: EmblemaParams());
  }

  Future<void> addEmblema(String idEmblema, BuildContext context) async {
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
    state = StatusBuild.done;
  }

  Future<void> carregaXpsUser() async {
    listXps.value = await _levelsUserRepository.listDocument(
      where: LevelsUserFilter(userId: user!.id!),
    );
  }

  Future<void> removerEmblema(String id, BuildContext context) async {
    final ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: '',
      context: context,
    );
    if (ret) {
      state = StatusBuild.loading;
      await _emblemaUserRepository.deletDocument(id: id);
      await loadAchievementsUser();
      state = StatusBuild.done;
    }
  }
}
