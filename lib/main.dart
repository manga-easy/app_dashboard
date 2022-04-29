import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppwriteAdmin().inicia());
  await Get.putAsync(() => AppwriteClient().inicia());
  await Get.putAsync(() => Global().inicia());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      initialRoute: AuthPage.router,
      getPages: [
        GetPage(
          name: MainScreen.router,
          page: () => MainScreen(),
        ),
        GetPage(
          name: UsersScreen.router,
          page: () => UsersScreen(),
        ),
        GetPage(
          name: UserDetalhesPage.router,
          page: () => UserDetalhesPage(),
        ),
        GetPage(
          name: AuthPage.router,
          page: () => AuthPage(),
        ),
        GetPage(
          name: CriarRecomendacaoPage.router,
          page: () => CriarRecomendacaoPage(),
        )
      ],
    );
  }
}
