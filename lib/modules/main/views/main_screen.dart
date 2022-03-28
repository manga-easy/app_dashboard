import 'package:dashboard_manga_easy/modules/dashboard/controllers/MenuController.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/dashboard_screen.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/views/recuperacao_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  static const router = '/home';
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
