import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/emblemas_controller.dart';
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
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
      route: EmblemasPage.route,
      valueListenable: ct.status,
      labelNovoItem: 'Novo Emblema',
      itemBuilderLista: (context, index) {
        Emblema emb = ct.lista[index];
        return ListTile(
          onTap: () => null,
          leading: emb.categoria ==  TypeEmblema.link.name ? CircleAvatar(
            radius: 35,
            foregroundImage: NetworkImage(),
          ),
          title: Text(use.name),
          subtitle: Text(
            use.email,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
          ),
        );
      },
      listaItems: ct.lista,
    );
  }
}
