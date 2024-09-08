import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final di = GetIt.instance;
Future<void> main() async {
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  //register all modules
  CoreModule().register();
  ServiceRoute.of.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en'),
      ],
      theme: ThemeData.dark(),
      routerConfig: ServiceRoute.of.routers,
      debugShowCheckedModeBanner: false,
    );
  }
}
