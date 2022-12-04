import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/emblemas_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/cria_edita_emblema_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasPage extends StatefulWidget {
  static const route = '/Emblemas';
  const EmblemasPage({Key? key}) : super(key: key);
  @override
  State<EmblemasPage> createState() => _EmblemasPageState();
}

class _EmblemasPageState extends State<EmblemasPage> {
  final ct = di.get<EmblemasController>();

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
    return ValueListenableBuilder<StatusBuild>(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: EmblemasPage.route,
          statusBuild: value,
          labelNovoItem: 'Novo Emblema',
          itemBuilderLista: (context, index) {
            Emblema emb = ct.lista[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(
                  context, CriaEditaEmblemaPage.route,
                  arguments: emb),
              leading: emb.type == TypeEmblema.link.name
                  ? CircleAvatar(
                      radius: 25,
                      foregroundImage: NetworkImage(emb.url),
                    )
                  : null,
              title: Text(emb.name),
              subtitle: Text(
                emb.categoria,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              ),
            );
          },
          onPressedAtualiza: () => ct.carregaEmblemas(),
          listaItems: ct.lista,
          onPressedNovoItem: () =>
              Navigator.pushNamed(context, CriaEditaEmblemaPage.route),
        );
      },
    );
  }
}
