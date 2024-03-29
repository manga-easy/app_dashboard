import 'package:dashboard_manga_easy/core/interfaces/service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/forbiden_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/cria_edita_emblema_page.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/ui/pages/emblemas_page.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_details_page.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_pages.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/pages/details_manga_page.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/notificacao_page.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/send_notification_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissions_model.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/edit_permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/permissoes_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/recomendacao_page.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/user_detalhe_page.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/users_page.dart';
import 'package:flutter/material.dart';

class ServiceRoute extends IService {
  bool isInicialize = false;
  static String? userId;
  static String? token;
  Permissions? permissions;
  @override
  Future<void> initialise() async {
    isInicialize = true;
  }

  Route<MaterialPageRoute>? generationRoutes(RouteSettings settings) {
    //verifica se foi inicializado os modulos
    if (!isInicialize) {
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
        settings: settings,
      );
    }
    //verifica se está logado
    if (userId == null) {
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
      case '/migrate':
        return MaterialPageRoute(
          builder: (_) => const DetailsMangaPage(),
          settings: settings,
        );
    }
    if (permissions!.value >= LevelPermissoes.suporte.value) {
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
        default:
      }
    }
    //somnte admin podem acessar as rotas abaixo
    if (permissions!.value < LevelPermissoes.admin.value) {
      return MaterialPageRoute(
        builder: (_) => const ForbidenPage(),
        settings: settings,
      );
    }
    switch (settings.name) {
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
      case EditPermissoesPage.route:
        return MaterialPageRoute(
          builder: (_) => const EditPermissoesPage(),
          settings: settings,
        );
      case SendNotificationPage.route:
        return MaterialPageRoute(
          builder: (_) => const SendNotificationPage(),
          settings: settings,
        );
      case HostPage.route:
        return MaterialPageRoute(
          builder: (_) => const HostPage(),
          settings: settings,
        );
      case HostDetailsPage.route:
        return MaterialPageRoute(
          builder: (_) => const HostDetailsPage(),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
