import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/chapter_authoral_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_comic_controller.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_chapter_comic_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:flutter/material.dart';

class EditComicAuthorialPage extends StatefulWidget {
  static const route = '/EditComicAuthorial';
  const EditComicAuthorialPage({Key? key}) : super(key: key);
  @override
  State<EditComicAuthorialPage> createState() => _EditComicAuthorialPageState();
}

class _EditComicAuthorialPageState extends State<EditComicAuthorialPage> {
  final ct = di.get<EditComicAuthorialController>();

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
            if (ct.comic == null) return const LoadingAtom();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      ct.comic!.cover,
                      width: 300,
                      height: 350,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CampoPadraoAtom(
                            hintText: 'Titulo',
                            initialValue: ct.comic!.title,
                            onChange: (p0) => ct.comic!.title = p0,
                          ),
                          const SizedBox(height: AppTheme.defaultPadding),
                          CampoPadraoAtom(
                            hintText: 'Sinopse',
                            initialValue: ct.comic!.sinopse,
                            numberLines: 5,
                            onChange: (p0) => ct.comic!.sinopse = p0,
                          ),
                          const SizedBox(height: AppTheme.defaultPadding),
                          CampoPadraoAtom(
                            hintText: 'Link da capa',
                            initialValue: ct.comic!.cover,
                            onChange: (p0) => ct.comic!.cover = p0,
                          ),
                          const SizedBox(height: AppTheme.defaultPadding),
                          CampoPadraoAtom(
                            hintText: 'Ano',
                            initialValue: ct.comic!.yearUp.toString(),
                            onChange: (p0) => ct.comic!.yearUp = int.tryParse(p0) ?? 0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                SizedBox(
                  height: 350,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chapters',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              EditChapterComicPage.route,
                              arguments: EditChapterComicParams(null, ct.comic!),
                            ),
                            icon: const Icon(Icons.add_box),
                          )
                        ],
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      FutureBuilder<List<ChapterAuthorial>>(
                        future: ct.getComic(),
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
                                      EditChapterComicPage.route,
                                      arguments: EditChapterComicParams(chapter, ct.comic!),
                                    ),
                                    title: Text(chapter.title),
                                    subtitle: Text(chapter.updateAt),
                                    trailing: Text(
                                      chapter.number.toString(),
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
                  onPress: () => ct.salvarComic(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
