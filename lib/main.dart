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
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

bool _isDemoUsingDynamicColors = false;

// Fictitious brand color.
const _brandBlue = Color(0xFF1E88E5);

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));
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

          _isDemoUsingDynamicColors = true; // ignore, only for demo purposes
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _dynamicMsg = _isDemoUsingDynamicColors ? ' (dynamic)' : ' (not dynamic)';
    String _harmonizedMsg =
        _isDemoUsingDynamicColors ? ' (harmonized with ColorScheme.primary)' : ' (not harmonized)';

    return Scaffold(
      body: Container(
        constraints: contentMaxWidth,
        padding: contentPadding,
        child: Column(
          children: [
            ColoredSquare(
              Theme.of(context).colorScheme.primary,
              'ColorScheme.primary$_dynamicMsg',
            ),
            ColoredSquare(
              Theme.of(context).extension<CustomColors>()!.danger,
              'CustomColors.danger$_harmonizedMsg',
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                errorText: 'This color is ColorScheme.error$_dynamicMsg',
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

const contentMaxWidth = BoxConstraints(maxWidth: 400);
const contentPadding = EdgeInsets.symmetric(horizontal: 10);

class ColoredSquare extends StatelessWidget {
  const ColoredSquare(this.color, this.description, {super.key});

  final Color? color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: color,
          ),
          const SizedBox(width: 10),
          Flexible(child: Text(description)),
        ],
      ),
    );
  }
}
