import 'package:dashboard_manga_easy/modules/dashboard/atoms/drawer_list_tile_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/controllers/menu_controller.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final MenuController menu;
  const SideMenu({
    Key? key,
    required this.menu,
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
          DrawerListTileAtom(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () => menu.trocarPage(0, context),
          ),
          DrawerListTileAtom(
            title: "Usuarios",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => menu.trocarPage(1, context),
          ),
          DrawerListTileAtom(
            title: "Notificações",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () => menu.trocarPage(2, context),
          ),
          DrawerListTileAtom(
            title: "Recuperação de conta",
            svgSrc: "assets/icons/menu_task.svg",
            press: () => menu.trocarPage(3, context),
          ),
          DrawerListTileAtom(
            title: "Recomendação",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () => menu.trocarPage(4, context),
          ),
        ],
      ),
    );
  }
}
