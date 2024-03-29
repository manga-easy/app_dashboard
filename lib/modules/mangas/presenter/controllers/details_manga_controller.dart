import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/info_comic_model.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';
import 'package:flutter/material.dart';

class DetailsMangaController extends IController {
  final MangaRepository mangaRepository;

  DetailsMangaController(this.mangaRepository);
  String? uniqueid;
  InfoComicModel? manga;

  @override
  void init(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    uniqueid = Helps.convertUniqueid(arguments['nameManga']!);
    loadingManga();
  }

  Future<void> loadingManga() async {
    try {
      state = StatusBuild.loading;
      final result = await mangaRepository.getManga(
        filter: MangaFilterEntity(
          uniqueid: uniqueid,
          genders: [],
        ),
      );
      manga = result.first;
    } catch (e) {
      Helps.log(e);
      state = StatusBuild.erro;
    }
    state = StatusBuild.done;
  }

  Future<void> updateManga() async {
    try {
      state = StatusBuild.loading;
      await mangaRepository.updateManga(manga: manga!);
    } catch (e) {
      Helps.log(e);
    }
    state = StatusBuild.done;
  }
}
