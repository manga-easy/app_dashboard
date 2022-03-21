import 'package:dashboard_manga_easy/controllers/MenuController.dart';
import 'package:dashboard_manga_easy/views/dashboard/dashboard_screen.dart';
import 'package:dashboard_manga_easy/views/main/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/views/notificacao/notificacao_page.dart';
import 'package:dashboard_manga_easy/views/recupercao/recuperacao_page.dart';
import 'package:dashboard_manga_easy/views/users/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final ct = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ct.scaffoldKey,
      drawer: SideMenu(),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(
            () => [
              DashboardScreen(),
              UsersScreen(),
              NotificacaoScreen(),
              RecuperacaoScreen(),
            ].elementAt(ct.page.value),
          ),
        ),
      ),
    );
  }
}
