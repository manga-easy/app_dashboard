import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/comic_controller.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_comic_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class ComicAuthorialPage extends StatefulWidget {
  static const route = '/ComicAuthorial';
  const ComicAuthorialPage({Key? key}) : super(key: key);
  @override
  State<ComicAuthorialPage> createState() => _ComicAuthorialPageState();
}

class _ComicAuthorialPageState extends State<ComicAuthorialPage> {
  final ct = di.get<ComicAuthorialController>();

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
    return ValueListenableBuilder<StatusBuild>(
      valueListenable: ct.status,
      builder: (context, value, chil) {
        return ModuloPageTemplate(
          onPressedNovoItem: () => Navigator.pushNamed(context, EditComicAuthorialPage.route),
          route: ComicAuthorialPage.route,
          statusBuild: value,
          onPressedAtualiza: ct.carregaComicAuthorialAutor,
          itemBuilderLista: (context, index) {
            var comic = ct.list[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        EditComicAuthorialPage.route,
                        arguments: comic,
                      ),
                      label: Text('Editar'),
                      icon: Icon(Icons.edit),
                    ),
                    TextButton.icon(
                      onPressed: () => null,
                      label: Text('Remover'),
                      icon: Icon(Icons.delete_forever),
                    ),
                  ],
                ),
                Card(
                  child: Row(
                    children: [
                      OctoImage(
                        width: 100,
                        height: 150,
                        image: NetworkImage(comic.cover),
                        placeholderBuilder: OctoPlaceholder.blurHash(
                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                        ),
                        errorBuilder: OctoError.icon(color: Colors.red),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Titulo: ${comic.title}'),
                            Text('Ano: ${comic.yearUp.toString()}'),
                            Text('Autor: ${comic.autor}'),
                            //Text('Ultimo capítulo: ${comic.chapter.last.title}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          listaItems: ct.list,
        );
      },
    );
  }
}
