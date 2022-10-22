import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/info_comic_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/view_comic_repository_inter.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class MangasController extends IController {
  final IViewComicRepository viewComicRepository;
  final IInforComicRepository infoComicRepository;
  final Global global;

  MangasController({
    required this.infoComicRepository,
    required this.global,
    required this.viewComicRepository,
  });

  String search = '';
  List<InfoComicModel> mangas = [];
  var status = ValueNotifier(StatusBuild.loading);

  @override
  void onClose() {
    mangas;
    status.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregarMangas();
  }

  void carregarMangas() async {
    try {
      status.value = StatusBuild.loading;
      mangas = await infoComicRepository.list(search: search);
      status.value = StatusBuild.done;
    } catch (e) {
      status.value = StatusBuild.erro;
      Helps.log(e);
    }
  }

  void alterIsAdult(InfoComicModel manga) {}

  Future<int> carregaViews(String uniqueid) async {
    return await viewComicRepository.total(uniqueid: uniqueid);
  }
}
