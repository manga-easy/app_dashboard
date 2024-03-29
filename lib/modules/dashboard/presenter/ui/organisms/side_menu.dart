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
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  ];

  SideMenu({
    Key? key,
    required this.atual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.white,
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
                  press: () => atual != e.route
                      ? Navigator.pushNamed(context, e.route)
                      : Navigator.pop(context),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: VersaoAppOrg(),
              ),
              TextButton(
                child: const Text('Sair'),
                onPressed: () {
                  _logoffService.call();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AuthPage.route,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
