import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/chapter_authoral_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/content_chapter_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/chapter_authoral_repository.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/comic_repository.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/content_chapter_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditChapterComicParams {
  final ChapterAuthorial? chapterAuthorial;
  final ComicAuthorialModel comicAuthorialModel;

  EditChapterComicParams(this.chapterAuthorial, this.comicAuthorialModel);
}

class EditChapterComicController extends IController {
  final ChapterAuthoralRepository chapterAuthoralRepository;
  final ComicAuthorialRepository comicAuthorialRepository;
  final ContentChapterRepository contentChapterRepository;

  ChapterAuthorial? chapterAuthorial;

  EditChapterComicController({
    required this.chapterAuthoralRepository,
    required this.comicAuthorialRepository,
    required this.contentChapterRepository,
  });

  @override
  Future<void> init(BuildContext context) async {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as EditChapterComicParams;
    chapterAuthorial = arguments.chapterAuthorial;
    var detailComic = await comicAuthorialRepository.get(
        id: arguments.comicAuthorialModel.id!);
    chapterAuthorial ??= ChapterAuthorial(
      idComicAuthorial: arguments.comicAuthorialModel.id!,
      title: '',
      number: detailComic!.chapter.isNotEmpty
          ? ++detailComic.chapter.last.number
          : 1,
      createAt: 'now()',
      updateAt: 'now()',
    );
    notifyListeners();
  }

  Future<void> salvarchapter(BuildContext context) async {
    try {
      if (chapterAuthorial!.title.isEmpty) {
        throw Exception('Titulo não pode ta vazio');
      }
      if (chapterAuthorial!.id == null) {
        await chapterAuthoralRepository.create(objeto: chapterAuthorial!);
      } else {
        await chapterAuthoralRepository.update(objeto: chapterAuthorial!);
      }
      Navigator.of(context).pop();

      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Obra salva com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
    notifyListeners();
  }

  Future<List<ContentChapterModel>> contentList() async {
    return await contentChapterRepository.list();
  }
}
