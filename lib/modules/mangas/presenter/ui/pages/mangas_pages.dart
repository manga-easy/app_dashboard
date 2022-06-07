import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/controllers/mangas_controllers.dart';
import 'package:flutter/material.dart';

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
    return ModuloPageTemplate(
      route: MangasPage.route,
      statusBuild: ct.status.value,
      itemBuilderLista: (context, dex) {
        var manga = ct.mangas.value[dex];
        return ListTile(
          leading: Image.network(manga.thumb),
          title: Text(manga.name),
        );
      },
      listaItems: ct.mangas.value,
    );
  }
}
