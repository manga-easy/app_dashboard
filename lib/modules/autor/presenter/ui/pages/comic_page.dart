import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/comic_controller.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/ui/pages/edit_comic_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class ComicPage extends StatefulWidget {
  static const route = '/Comic';
  const ComicPage({Key? key}) : super(key: key);
  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  final ct = di.get<ComicController>();

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
          onPressedNovoItem: () => Navigator.pushNamed(context, EditComicPage.route),
          route: ComicPage.route,
          statusBuild: value,
          onPressedAtualiza: ct.carregaComicAutor,
          itemBuilderLista: (context, index) {
            var comic = ct.list[index];
            return Card(
              child: Row(
                //direction: Axis.horizontal,
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
                        Text(comic.title),
                        Text('Ultimo capítulo:'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listaItems: ct.list,
        );
      },
    );
  }
}
