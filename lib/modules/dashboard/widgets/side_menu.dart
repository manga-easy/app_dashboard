import 'package:dashboard_manga_easy/modules/dashboard/atoms/drawer_list_tile_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/views/recuperacao_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final String atual;
  const SideMenu({
    Key? key,
    required this.atual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              MainPage.route,
              UsersPage.route,
              RecomendacaoPage.route,
              RecuperacaoPage.route,
              NotificacaoPage.route
            ]
                .map(
                  (e) => DrawerListTileAtom(
                    title: e.replaceAll('/', ''),
                    svgSrc: "assets/icons/${e.replaceAll('/', '').toLowerCase()}.svg",
                    press: () => atual != e ? Navigator.pushNamed(context, e) : Navigator.pop(context),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
