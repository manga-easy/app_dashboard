import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ComicController extends IController {
  final ComicRepository comicRepository;
  var status = ValueNotifier(StatusBuild.loading);
  var list = <ComicModel>[];

  ComicController({required this.comicRepository});

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onInit(BuildContext context) {
    carregaComicAutor();
  }

  Future<void> carregaComicAutor() async {
    try {
      status.value = StatusBuild.loading;
      list = await comicRepository.list();
      status.value = StatusBuild.done;
    } catch (e) {
      Helps.log(e);
      status.value = StatusBuild.erro;
    }
  }
}
