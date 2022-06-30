import 'package:dashboard_manga_easy/core/interfaces/service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/detalhes_emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/forbiden_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/cria_edita_emblema_page.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/views/emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/mangas_pages.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recupercao/views/recuperacao_page.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
import 'package:dashboard_manga_easy/modules/users/views/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class ServiceRoute extends IService {
  bool isInicialize = false;
  User? user;
  Permissions? permissions;
  final levelAdmin = 80;
  @override
  Future<void> initialise() async {
    isInicialize = true;
  }

  Route<MaterialPageRoute>? generationRoutes(RouteSettings settings) {
    print(user);
    print(settings.name);
    //verifica se foi inicializado os modulos
    if (!isInicialize) {
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
        settings: settings,
      );
    }
    //verifica se está logado
    if (user == null) {
      return MaterialPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    }
    //acesso ao pessoal comun do dashboard (parceiros, autores e outros)
    switch (settings.name) {
      case MainPage.route:
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
          settings: settings,
        );
      case MangasPage.route:
        return MaterialPageRoute(
          builder: (_) => const MangasPage(),
          settings: settings,
        );
    }
    //somnte admin podem acessar as rotas abaixo
    if (permissions!.value < levelAdmin) {
      return MaterialPageRoute(
        builder: (_) => const ForbidenPage(),
        settings: settings,
      );
    }
    switch (settings.name) {
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
      case PermissoesPage.route:
        return MaterialPageRoute(
          builder: (_) => const PermissoesPage(),
          settings: settings,
        );
      default:
        return null;
    }
  }

  List<String> menuRoutes() {
    if (permissions!.value >= levelAdmin) {
      return [
        MainPage.route,
        UsersPage.route,
        RecomendacaoPage.route,
        RecuperacaoPage.route,
        NotificacaoPage.route,
        EmblemasPage.route,
        BannerPage.route,
        MangasPage.route,
        PermissoesPage.route,
      ];
    }
    return [
      MainPage.route,
      MangasPage.route,
    ];
  }
}
