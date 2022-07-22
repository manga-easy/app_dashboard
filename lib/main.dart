import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/auth_module.dart';
import 'package:dashboard_manga_easy/modules/banners/banners_module.dart';
import 'package:dashboard_manga_easy/modules/dashboard/dashboard_module.dart';
import 'package:dashboard_manga_easy/modules/emblemas/emblemas_module.dart';
import 'package:dashboard_manga_easy/modules/enquente/enquete_module.dart';
import 'package:dashboard_manga_easy/modules/mangas/mangas_modules.dart';
import 'package:dashboard_manga_easy/modules/notificacao/notificacao_module.dart';
import 'package:dashboard_manga_easy/modules/permissoes/permissoes_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/recomendacao_module.dart';
import 'package:dashboard_manga_easy/modules/splash/splash_module.dart';
import 'package:dashboard_manga_easy/modules/temporadas/temporadas_module.dart';
import 'package:dashboard_manga_easy/modules/users/users_module.dart';
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
  UsersModule().register();
  EmblemasModule().register();
  BannersModule().register();
  MangasModule().register();
  PermissoesModule().register();
  TemporadasModule().register();
  EnqueteModule().register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceRoute serviceRoute = di.get();
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
      onGenerateRoute: serviceRoute.generationRoutes,
    );
  }
}
