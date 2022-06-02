import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/auth/auth_module.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/banners/banners_module.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/dashboard_module.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/detalhes_emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/emblemas/emblemas_module.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/cria_edita_emblema_page.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/notificacao/notificacao_module.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/recomendacao_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/recuperacao_module.dart';
import 'package:dashboard_manga_easy/modules/recupercao/views/recuperacao_page.dart';
import 'package:dashboard_manga_easy/modules/splash/splash_module.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
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
  SplashModule().register();
  DashboardModule().register();
  NotificacaoModule().register();
  RecomendacaoModule().register();
  RecuperacaooModule().register();
  UsersModule().register();
  EmblemasModule().register();
  BannersModule().register();
  runApp(const MyApp());
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
      initialRoute: SplashPage.route,
      onGenerateRoute: (settings) {
        if ((SplashPage.route == settings.name || di.get<Global>().user == null) &&
            settings.name != AuthPage.route) {
          return MaterialPageRoute(
            builder: (_) => const SplashPage(),
            settings: settings,
          );
        }
        switch (settings.name) {
          case MainPage.route:
            return MaterialPageRoute(
              builder: (_) => const MainPage(),
              settings: settings,
            );
          case UsersPage.route:
            return MaterialPageRoute(
              builder: (_) => const UsersPage(),
              settings: settings,
            );
          case UserDetalhesPage.route:
            return MaterialPageRoute(
              builder: (_) => const UserDetalhesPage(),
              settings: settings,
            );
          case AuthPage.route:
            return MaterialPageRoute(
              builder: (_) => const AuthPage(),
              settings: settings,
            );
          case CriarRecomendacaoPage.route:
            return MaterialPageRoute(
              builder: (_) => const CriarRecomendacaoPage(),
              settings: settings,
            );
          case RecomendacaoPage.route:
            return MaterialPageRoute(
              builder: (_) => const RecomendacaoPage(),
              settings: settings,
            );
          case NotificacaoPage.route:
            return MaterialPageRoute(
              builder: (_) => const NotificacaoPage(),
              settings: settings,
            );
          case RecuperacaoPage.route:
            return MaterialPageRoute(
              builder: (_) => const RecuperacaoPage(),
              settings: settings,
            );
          case EmblemasPage.route:
            return MaterialPageRoute(
              builder: (_) => const EmblemasPage(),
              settings: settings,
            );
          case CriaEditaEmblemaPage.route:
            return MaterialPageRoute(
              builder: (_) => const CriaEditaEmblemaPage(),
              settings: settings,
            );
          case DetalhesEmblemasPage.route:
            return MaterialPageRoute(
              builder: (_) => const DetalhesEmblemasPage(),
              settings: settings,
            );
          case CriarBannerPage.route:
            return MaterialPageRoute(
              builder: (_) => const CriarBannerPage(),
              settings: settings,
            );
          case BannerPage.route:
            return MaterialPageRoute(
              builder: (_) => const BannerPage(),
              settings: settings,
            );
          default:
            return null;
        }
      },
    );
  }
}
