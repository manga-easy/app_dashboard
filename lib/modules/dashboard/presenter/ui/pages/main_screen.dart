import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/emblemas_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class MainPage extends StatefulWidget {
  static const route = '/';
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ManagerPage<DashboardController, MainPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: MainPage.route,
      state: ct.state,
      error: ct.error,
      onPressedAtualiza: () => ct.carregaEmblemaDoadores(),
      itemBuilderLista: (context, index) {
        final emblems = ct.emblemasDoadores[index];
        return ListTile(
          onTap: () => context.push('${EmblemasPage.route}/${emblems.id}'),
          leading: CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(emblems.url),
          ),
          title: Text(emblems.name),
          subtitle: Text(
            emblems.category.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
      listaItems: ct.emblemasDoadores,
    );
  }
}
