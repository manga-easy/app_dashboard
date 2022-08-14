import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:flutter/material.dart';

class EditChapterComicPage extends StatefulWidget {
  static const route = '/EditChapterComic';
  const EditChapterComicPage({Key? key}) : super(key: key);
  @override
  State<EditChapterComicPage> createState() => _EditChapterComicPageState();
}

class _EditChapterComicPageState extends State<EditChapterComicPage> {
  final ct = di.get<EditChapterComicController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar ComicAuthorial'),
      ),
      body: Container(
        margin: const EdgeInsets.all(AppTheme.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder(
          valueListenable: ct,
          builder: (context, value, child) {
            if (ct.chapterAuthorial == null) return const LoadingAtom();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
              children: [
                CampoPadraoAtom(
                  hintText: 'Titulo',
                  initialValue: ct.chapterAuthorial!.title,
                  onChange: (p0) => ct.chapterAuthorial!.title = p0,
                ),
                CampoPadraoAtom(
                  hintText: 'Number',
                  initialValue: ct.chapterAuthorial!.number.toString(),
                  onChange: (p0) => ct.chapterAuthorial!.number = double.tryParse(p0) ?? 0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar',
                  icone: Icons.create,
                  onPress: () => ct.salvarchapter(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
