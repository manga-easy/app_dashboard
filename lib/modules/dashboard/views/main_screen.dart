import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/controllers/MenuController.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/dashboard_screen.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/views/recuperacao_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const route = '/Main';
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ct = di.get<MenuController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ct.scaffoldKey,
      drawer: SideMenu(menu: ct),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedBuilder(
            animation: ct.page,
            builder: (context, child) {
              switch (ct.page.value) {
                case 0:
                  return const DashboardScreen();
                case 1:
                  return const UsersPage();
                case 2:
                  return const NotificacaoPage();
                case 3:
                  return const RecuperacaoPage();
                case 4:
                  return const RecomendacaoPage();
                default:
                  return const Text('kd ?');
              }
            },
          ),
        ),
      ),
    );
  }
}
