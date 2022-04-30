import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/modules/auth/auth_module.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/dashboard_module.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/notificacao/notificacao_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/recomendacao_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/recuperacao_module.dart';
import 'package:dashboard_manga_easy/modules/users/users_module.dart';
import 'package:dashboard_manga_easy/modules/users/views/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

final di = GetIt.instance;
Future<void> main() async {
  //register all modules
  CoreModule().register();
  AuthModule().register();
  DashboardModule().register();
  NotificacaoModule().register();
  RecomendacaoModule().register();
  RecuperacaooModule().register();
  UsersModule().register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Mangá Easy',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTheme.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
        ),
        canvasColor: AppTheme.secondaryColor,
      ),
      initialRoute: AuthPage.route,
      routes: {
        MainPage.route: (context) => const MainPage(),
        UsersPage.route: (context) => const UsersPage(),
        UserDetalhesPage.route: (context) => const UserDetalhesPage(),
        AuthPage.route: (context) => const AuthPage(),
        CriarRecomendacaoPage.route: (context) => const CriarRecomendacaoPage(),
      },
    );
  }
}
