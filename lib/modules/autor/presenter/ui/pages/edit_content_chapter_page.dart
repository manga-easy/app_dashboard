import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_content_chapter_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/oranisms/editor_texto.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class EditContentChapterPage extends StatefulWidget {
  static const route = '/EditContentChapter';
  const EditContentChapterPage({Key? key}) : super(key: key);
  @override
  State<EditContentChapterPage> createState() => _EditContentChapterPageState();
}

class _EditContentChapterPageState extends State<EditContentChapterPage> {
  final ct = di.get<EditContentChapterController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conteudo'),
      ),
      body: Container(
        margin: const EdgeInsets.all(AppTheme.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder(
          valueListenable: ct,
          builder: (context, value, child) {
            if (ct.contentChapter == null) return const LoadingAtom();
            return ct.contentChapter!.type == 'text'
                ? HtmlEditorExample(
                    title: 'Conteudo',
                    controller: ct.controller,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
