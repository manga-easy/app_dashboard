import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          onChangePesquisa: (v) => ct.search = v,
          onEditCompletPesquisa: ct.carregarMangas,
          onPressedAtualiza: ct.carregarMangas,
          statusBuild: ct.status.value,
          itemBuilderLista: (context, dex) {
            var manga = ct.mangas[dex];
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //direction: Axis.horizontal,
                  children: [
                    OctoImage(
                      width: 100,
                      height: 150,
                      image: NetworkImage(manga.thumb, headers: Map.from(ct.global.header)),
                      placeholderBuilder: OctoPlaceholder.blurHash(
                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                      ),
                      errorBuilder: OctoError.icon(
                        color: Colors.red,
                      ),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: manga.name));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Copiado com sucesso'),
                              ));
                            },
                            child: Text(
                              manga.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ratio: ${manga.ratio}'),
                              IconButton(
                                onPressed: () => ct.alterIsAdult(manga),
                                icon: Icon(
                                  Icons.no_adult_content,
                                  color: manga.isAdult ? Colors.red : null,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text('Ultimo capítulo: ${manga.ultimoCap}'),
                          const SizedBox(height: 5),
                          FutureBuilder<int>(
                            future: ct.carregaViews(manga.uniqueid),
                            builder: (context, value) {
                              if (value.hasError) {
                                return Text('Erro: ${value.error}');
                              }
                              if (value.hasData) {
                                return Text('Views: ${value.data}');
                              }
                              return const SizedBox(
                                height: 32,
                                width: 32,
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            children: manga.generos
                                .split('<>')
                                .map(
                                  (e) => Chip(
                                    label: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listaItems: ct.mangas,
        );
      },
    );
  }
}
