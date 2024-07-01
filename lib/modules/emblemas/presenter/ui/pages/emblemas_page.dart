import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/emblemas_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/cria_edita_emblema_page.dart';
import 'package:flutter/material.dart';

class EmblemasPage extends StatefulWidget {
  static const route = '/Emblemas';
  const EmblemasPage({super.key});
  @override
  State<EmblemasPage> createState() => _EmblemasPageState();
}

class _EmblemasPageState extends State<EmblemasPage> {
  final EmblemasController ct = di();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    ct.onMessage(listernerMessage);
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null && mounted) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: EmblemasPage.route,
      statusBuild: ct.state,
      onChangePesquisa: (v) => ct.search = v,
      labelNovoItem: 'Novo Emblema',
      itemBuilderLista: (context, index) {
        final Emblema emb = ct.lista[index];
        if (!emb.name.toLowerCase().contains(ct.search.toLowerCase()) &&
            ct.search.isNotEmpty) {
          return const SizedBox.shrink();
        }
        return ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            CriaEditaEmblemaPage.route,
            arguments: emb,
          ),
          leading: CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(emb.url),
          ),
          title: Text(emb.name),
          subtitle: Text(
            emb.categoria,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        );
      },
      onPressedAtualiza: () => ct.carregaEmblemas(),
      listaItems: ct.lista,
      onPressedNovoItem: () => Navigator.pushNamed(
        context,
        CriaEditaEmblemaPage.route,
      ),
    );
  }
}
