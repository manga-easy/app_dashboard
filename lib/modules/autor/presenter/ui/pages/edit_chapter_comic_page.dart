import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/content_chapter_model.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_content_chapter_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_content_chapter_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
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
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.defaultPadding),
              children: [
                CampoPadraoAtom(
                  hintText: 'Titulo',
                  initialValue: ct.chapterAuthorial!.title,
                  onChange: (p0) => ct.chapterAuthorial!.title = p0,
                ),
                CampoPadraoAtom(
                  hintText: 'Number',
                  initialValue: ct.chapterAuthorial!.number.toString(),
                  onChange: (p0) =>
                      ct.chapterAuthorial!.number = double.tryParse(p0) ?? 0,
                ),
                SizedBox(
                  height: 350,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Conteudo',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              EditContentChapterPage.route,
                              arguments: EditcontentChapterParams(
                                  ct.chapterAuthorial!, null),
                            ).then((value) => ct.notifyListeners()),
                            icon: const Icon(Icons.add_box),
                          )
                        ],
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      FutureBuilder<List<ContentChapterModel>>(
                        future: ct.contentList(),
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return Text(snap.error.toString());
                          }
                          if (snap.data != null) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snap.data!.length,
                                itemBuilder: (context, index) {
                                  var chapter = snap.data![index];
                                  return ListTile(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      EditContentChapterPage.route,
                                      arguments: EditcontentChapterParams(
                                          ct.chapterAuthorial!, chapter),
                                    ),
                                    title: Text(chapter.content),
                                    subtitle: Text(chapter.updateAt),
                                    trailing: Text(
                                      chapter.type,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
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
