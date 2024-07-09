import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/emblemas_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/cria_edita_emblema_page.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class EmblemasPage extends StatefulWidget {
  static const route = '/Emblemas';
  const EmblemasPage({super.key});
  @override
  State<EmblemasPage> createState() => _EmblemasPageState();
}

class _EmblemasPageState extends ManagerPage<EmblemasController, EmblemasPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      error: ct.error,
      route: EmblemasPage.route,
      state: ct.state,
      onChangePesquisa: (v) => ct.search = v,
      labelNovoItem: 'Novo Emblema',
      itemBuilderLista: (context, index) {
        final AchievementEntity emb = ct.lista[index];
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
            emb.category.name,
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
