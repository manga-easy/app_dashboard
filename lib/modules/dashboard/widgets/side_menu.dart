import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/drawer_list_tile_atom.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final ServiceRoute serviceRoute = di.get();
  final String atual;
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
              "assets/images/logo.png",
              color: Colors.white,
            ),
          ),
          Column(
            children: serviceRoute
                .menuRoutes()
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
