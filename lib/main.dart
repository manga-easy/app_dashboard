import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/auth_module.dart';
import 'package:dashboard_manga_easy/modules/autor/autor_module.dart';
import 'package:dashboard_manga_easy/modules/banners/banners_module.dart';
import 'package:dashboard_manga_easy/modules/configApp/config_app_modules.dart';
import 'package:dashboard_manga_easy/modules/dashboard/dashboard_module.dart';
import 'package:dashboard_manga_easy/modules/emblemas/emblemas_module.dart';
import 'package:dashboard_manga_easy/modules/enquente/enquete_module.dart';
import 'package:dashboard_manga_easy/modules/host/host_module.dart';
import 'package:dashboard_manga_easy/modules/mangas/mangas_modules.dart';
import 'package:dashboard_manga_easy/modules/notificacao/notificacao_module.dart';
import 'package:dashboard_manga_easy/modules/permissoes/permissoes_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/recomendacao_module.dart';
import 'package:dashboard_manga_easy/modules/splash/splash_module.dart';
import 'package:dashboard_manga_easy/modules/temporadas/temporadas_module.dart';
import 'package:dashboard_manga_easy/modules/users/users_module.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

bool isDemoUsingDynamicColors = false;

// Fictitious brand color.
const _brandBlue = Color(0xFF1E88E5);

var lightCustomColors =
    const CustomColors(danger: Color.fromARGB(255, 56, 53, 229));
var darkCustomColors =
    const CustomColors(danger: Color.fromARGB(255, 154, 198, 239));
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
  AutorModule().register();
  ConfigAppModule().register();
  HostModule().register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceRoute serviceRoute = di.get();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
          lightColorScheme = lightDynamic.harmonized();
          // (Optional) Customize the scheme as desired. For example, one might
          // want to use a brand color to override the dynamic [ColorScheme.secondary].
          lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);
          // (Optional) If applicable, harmonize custom colors.
          lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
          darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
          darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

          isDemoUsingDynamicColors = true; // ignore, only for demo purposes
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            extensions: [lightCustomColors],
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            extensions: [darkCustomColors],
          ),
          onGenerateRoute: serviceRoute.generationRoutes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}
