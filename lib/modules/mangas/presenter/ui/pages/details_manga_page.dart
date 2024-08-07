import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/core/libraries/widgets/manga_cover/manga_cover.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/details_manga_controller.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/organisms/all_genders.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/organisms/section_genders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_manager/manager_page.dart';

class DetailsMangaPage extends StatefulWidget {
  static const route = '/manga-deatails';
  const DetailsMangaPage({super.key});

  @override
  State<DetailsMangaPage> createState() => _DetailsMangaPageState();
}

class _DetailsMangaPageState
    extends ManagerPage<DetailsMangaController, DetailsMangaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      appBar: Text('Editar ${ct.uniqueid}'),
      error: ct.error,
      state: ct.state,
      pageDone: () => Container(
        margin: const EdgeInsets.all(AppTheme.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.defaultPadding,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CoffeeMangaCover(
                  filtraImg: true,
                  height: 250,
                  width: 200,
                  cover: ct.manga!.thumb,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: ct.manga!.name));
              },
              child: Text(
                'Nome: ${ct.manga!.name}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            CampoPadraoAtom(
              hintText: 'Capa',
              onChange: (v) => ct.manga!.thumb = v,
              initialValue: ct.manga!.thumb,
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            CampoPadraoAtom(
              hintText: 'Autor',
              onChange: (v) => ct.manga!.author = v,
              initialValue: ct.manga!.author,
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            CampoPadraoAtom(
              hintText: 'scans',
              onChange: (v) => ct.manga!.scans = v,
              initialValue: ct.manga!.scans,
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            CampoPadraoAtom(
              hintText: 'Sinopse',
              onChange: (v) => ct.manga!.synopsis = v,
              numberLines: 5,
              initialValue: ct.manga!.synopsis,
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            SectionGenders(
              genders: ct.manga!.genres.split('<>'),
              onRemove: (String gender) {
                setState(() {
                  ct.manga!.genres = ct.manga!.genres.replaceFirst(
                    '<>$gender',
                    '',
                  );
                });
              },
              onAdd: () async {
                final ret = await showModalBottomSheet(
                  context: context,
                  builder: (context) => const AllGenders(),
                );
                if (ret != null) {
                  if (!ct.manga!.genres.contains(ret)) {
                    setState(() {
                      ct.manga!.genres += '<>$ret';
                    });
                  }
                }
              },
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            ButtonPadraoAtom(
              title: 'Salvar',
              icone: Icons.create,
              onPress: ct.updateManga,
            ),
          ],
        ),
      ),
    );
  }
}
