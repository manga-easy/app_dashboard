import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class MangasPage extends StatefulWidget {
  static const route = '/Mangas';
  const MangasPage({Key? key}) : super(key: key);
  @override
  State<MangasPage> createState() => _MangasPageState();
}

class _MangasPageState extends State<MangasPage> {
  final ct = di.get<MangasController>();

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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: MangasPage.route,
          onChangePesquisa: (v) => ct.pesquisa = v,
          onEditCompletPesquisa: ct.carregarMangas,
          statusBuild: ct.status.value,
          itemBuilderLista: (context, dex) {
            var manga = ct.mangas.value[dex];
            return Card(
              child: Row(
                //direction: Axis.horizontal,
                children: [
                  OctoImage(
                    width: 100,
                    height: 150,
                    image: NetworkImage(manga.thumb, headers: Map.from(ct.global.header)),
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
                        Text(manga.name),
                        Text('Ultimo capítulo: ${manga.ultimoCap}'),
                        FutureBuilder<int>(
                          future: ct.carregaViews(manga.uniqueid),
                          builder: (context, value) {
                            if (value.hasError) {
                              return Text('Erro: ${value.error}');
                            }
                            if (value.hasData) {
                              return Text('Views: ${value.data}');
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listaItems: ct.mangas.value,
        );
      },
    );
  }
}
