import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';

import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class ComicAuthorialController extends IController {
  final ComicAuthorialRepository comicRepository;
  var list = <ComicAuthorialModel>[];

  ComicAuthorialController({required this.comicRepository});

  @override
  void init(BuildContext context) {
    carregaComicAuthorialAutor();
  }

  Future<void> carregaComicAuthorialAutor() async {
    try {
      state = StatusBuild.loading;
      list = await comicRepository.list();
      state = StatusBuild.done;
    } catch (e) {
      Helps.log(e);
      state = StatusBuild.erro;
    }
  }
}
