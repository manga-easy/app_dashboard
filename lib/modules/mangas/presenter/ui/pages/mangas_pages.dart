import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/atoms/card_manga.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class MangasPage extends StatefulWidget {
  static const route = '/Mangas';
  const MangasPage({Key? key}) : super(key: key);
  @override
  State<MangasPage> createState() => _MangasPageState();
}

class _MangasPageState extends State<MangasPage> {
  final MangasController ct = di();

  @override
  void initState() {
    ct.pagingController.addPageRequestListener((pageKey) {
      ct.fetchPage(pageKey);
    });
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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: MangasPage.route,
          onChangePesquisa: (v) => ct.search = v,
          onEditCompletPesquisa: () => ct.pagingController.refresh(),
          statusBuild: ct.status.value,
          child: Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: ct.total,
                      builder: (context, value, child) =>
                          Text('Total de mangas: $value'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: PagedListView<int, InfoComicModel>(
                    pagingController: ct.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<InfoComicModel>(
                      itemBuilder: (context, item, index) {
                        return CardManga(
                          manga: item,
                          loadingViews: ct.carregaViews,
                          alterIsAdult: ct.alterIsAdult,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
