import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ComicAuthorialController extends IController {
  final ComicAuthorialRepository comicRepository;
  var status = ValueNotifier(StatusBuild.loading);
  var list = <ComicAuthorialModel>[];

  ComicAuthorialController({required this.comicRepository});

  @override
  void close() {
    status.dispose();
    dispose();
  }

  @override
  void init(BuildContext context) {
    carregaComicAuthorialAutor();
  }

  Future<void> carregaComicAuthorialAutor() async {
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
