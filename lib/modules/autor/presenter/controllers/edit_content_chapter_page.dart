import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/chapter_authoral_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/content_chapter_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/content_chapter_repository.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditcontentChapterParams {
  final ContentChapterModel? contentChapterModel;
  final ChapterAuthorial chapterAuthorial;

  EditcontentChapterParams(this.chapterAuthorial, this.contentChapterModel);
}

class EditContentChapterController extends IController {
  final HtmlEditorController controller = HtmlEditorController();
  final ContentChapterRepository contentChapterRepository;

  EditContentChapterController({required this.contentChapterRepository});

  ContentChapterModel? contentChapter;

  @override
  void dispose() {
    super.dispose();
    controller.disable();
  }

  @override
  void init(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as EditcontentChapterParams;
    contentChapter = arguments.contentChapterModel;
    contentChapter ??= ContentChapterModel(
      idChapter: arguments.chapterAuthorial.id!,
      content: '',
      type: 'text',
      createat: 'now()',
      updateAt: 'now()',
    );
    notifyListeners();
  }

  void salvarContent(BuildContext context) async {
    try {
      contentChapter!.content = await controller.getText();
      if (contentChapter!.content.isEmpty) {
        throw Exception('O conteudo não pode ta vazio');
      }
      if (contentChapter!.id == null) {
        await contentChapterRepository.create(objeto: contentChapter!);
      } else {
        await contentChapterRepository.update(objeto: contentChapter!);
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
}
