import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/services/logoff_service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/drawer_list_tile_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/menu_item.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/versao_app_org.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_pages.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/mangas_pages.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/pages/toggles_page.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  final LogoffService _logoffService = GetIt.I();
  final String atual;
  final List<MenuItem> menu = [
    MenuItem(route: MainPage.route, title: 'Home'),
    MenuItem(route: MangasPage.route, title: 'Catalogo'),
    MenuItem(route: UsersPage.route, title: 'Usuarios'),
    MenuItem(route: RecomendacaoPage.route, title: 'Recomendações'),
    MenuItem(route: NotificacaoPage.route, title: 'Notificações'),
    MenuItem(route: EmblemasPage.route, title: 'Emblemas'),
    MenuItem(route: BannerPage.route, title: 'Banners'),
    MenuItem(route: PermissoesPage.route, title: 'Permissões'),
    MenuItem(route: HostPage.route, title: 'Hosts'),
    MenuItem(route: TogglesPage.route, title: 'Toggles'),
  ];

  SideMenu({
    super.key,
    required this.atual,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/images/logo.png',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final e = menu[index];
                return DrawerListTileAtom(
                  title: e.title,
                  svgSrc: e.icon ?? 'assets/icons/configApp.svg',
                  press: () =>
                      atual != e.route ? context.push(e.route) : context.pop(),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const VersaoAppOrg(),
                    Text(
                      Helps.isProd ? 'Produção' : 'Teste',
                    ),
                  ],
                ),
              ),
              TextButton(
                child: const Text('Sair'),
                onPressed: () {
                  _logoffService.call();
                  context.pushReplacement(AuthPage.route);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
