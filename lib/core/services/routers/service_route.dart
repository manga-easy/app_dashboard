import 'dart:developer';

import 'package:dashboard_manga_easy/core/services/routers/module_factory.dart';
import 'package:dashboard_manga_easy/modules/auth/auth_module.dart';
import 'package:dashboard_manga_easy/modules/auth/data/repositories/credencial_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:dashboard_manga_easy/modules/banners/banners_module.dart';
import 'package:dashboard_manga_easy/modules/dashboard/dashboard_module.dart';
import 'package:dashboard_manga_easy/modules/emblemas/emblemas_module.dart';
import 'package:dashboard_manga_easy/modules/host/host_module.dart';
import 'package:dashboard_manga_easy/modules/mangas/mangas_modules.dart';
import 'package:dashboard_manga_easy/modules/notificacao/notificacao_module.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';
import 'package:dashboard_manga_easy/modules/permissoes/permissoes_module.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/recomendacao_module.dart';
import 'package:dashboard_manga_easy/modules/splash/splash_module.dart';
import 'package:dashboard_manga_easy/modules/splash/views/splash_view.dart';
import 'package:dashboard_manga_easy/modules/staff/staff_module.dart';
import 'package:dashboard_manga_easy/modules/toggles/toggles_module.dart';
import 'package:dashboard_manga_easy/modules/update_notes/update_notes_module.dart';
import 'package:dashboard_manga_easy/modules/users/users_module.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ServiceRoute {
  factory ServiceRoute() {
    return _singleton;
  }
  static final ServiceRoute _singleton = ServiceRoute._internal();

  ServiceRoute._internal();

  static ServiceRoute get of => ServiceRoute();
  bool isInicialize = false;
  static String? userId;
  static String? token;
  String? initalRoute;
  Permission? permissions;
  final List<RouteBase> _routes = [];
  final List<Module> modules = [
    AuthModule(),
    SplashModule(),
    DashboardModule(),
    NotificacaoModule(),
    RecomendacaoModule(),
    UsersModule(),
    EmblemasModule(),
    BannersModule(),
    MangasModule(),
    PermissoesModule(),
    HostModule(),
    TogglesModule(),
    UpdateNotesModule(),
    StaffModule(),
  ];

  Future<void> initialise() async {
    final respository = GetIt.I<CredencialRepository>();
    final credencial = await respository.get();
    userId = credencial?.userId;
    token = credencial?.token;
    isInicialize = true;
  }

  void register() {
    for (final element in modules) {
      element.register();
      _routes.addAll(element.routes());
    }
  }

  String? _guard(BuildContext context, GoRouterState state) {
    log('============= route: ${state.uri.toString()}', name: 'Guard');
    if (!isInicialize) {
      if (state.uri.toString() != SplashPage.route) {
        initalRoute = state.uri.toString();
      }
      return SplashPage.route;
    }
    if (userId == null) {
      return AuthPage.route;
    }
    if (initalRoute != null && state.uri.toString() != SplashPage.route) {
      final route = initalRoute;
      initalRoute = null;
      return route;
    }
    // no redirect
    return null;
  }

  GoRouter get routers => GoRouter(
        redirect: _guard,
        routes: _routes,
      );
}
