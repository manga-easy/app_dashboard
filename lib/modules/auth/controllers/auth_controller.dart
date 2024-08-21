import 'dart:async';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/data/repositories/credencial_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/export_manager.dart';

class AuthController extends ManagerStore<String> {
  final CredencialRepository _credencialRepo;
  final PermissionsRepository _permissionsRepository;
  final ServiceRoute _serviceRoute;
  final AuthService _authService;

  AuthController(
    this._credencialRepo,
    this._serviceRoute,
    this._authService,
    this._permissionsRepository,
  );
  CredencialModel? credencialModel;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    await carregaCredencial();
    state = StateManager.done;
  }

  void logar(BuildContext context) => handleTry(
        call: () async {
          final session = await _authService.createSession(
            email: email.text,
            password: password.text,
          );
          ServiceRoute.userId = session.userId;
          ServiceRoute.token = await _authService.getJwt();
          await validacaoPermissao(session.userId);
          await salvaCredencial();
          emitNavigation(MainPage.route);
        },
      );

  Future<void> validacaoPermissao(String userId) async {
    final result = await _permissionsRepository.getByUser(userId: userId);

    _serviceRoute.permissions = result;
  }

  Future<void> carregaCredencial() async {
    credencialModel = await _credencialRepo.get();
    if (credencialModel != null) {
      email.text = credencialModel!.email;
    }
  }

  Future<void> salvaCredencial() async {
    final cred = CredencialModel(
      email: email.text,
      token: ServiceRoute.token,
      userId: ServiceRoute.userId,
    );
    await _credencialRepo.put(objeto: cred);
  }
}
