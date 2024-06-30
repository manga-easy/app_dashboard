import 'dart:async';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:flutter/material.dart';

class AuthController extends IController {
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
  Future<void> init(BuildContext context) async {
    await carregaCredencial();
    if (context.mounted) {
      await loginAutomatico(context);
    }
  }

  Future<void> logar(context) async {
    try {
      final session = await _authService.createSession(
        email: email.text,
        password: password.text,
      );
      ServiceRoute.userId = session.userId;
      ServiceRoute.token = await _authService.getJwt();
      await validacaoPermissao(session.userId);
      await salvaCredencial();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.route,
        (route) => false,
      );
    } on Exception catch (e) {
      handlerError(e, context);
    }
  }

  Future<void> validacaoPermissao(String userId) async {
    final result = await _permissionsRepository.listDocument(
        where: PermissoesParams(
      userId: userId,
    ),);

    _serviceRoute.permissions = result.first;
  }

  Future<void> carregaCredencial() async {
    final ret = await _credencialRepo.list();
    if (ret.isNotEmpty) {
      credencialModel = ret.first;
      email.text = credencialModel!.email;
    }
  }

  Future<void> salvaCredencial() async {
    final cred = CredencialModel(email: email.text);
    await _credencialRepo.put(objeto: cred);
  }

  Future<void> loginAutomatico(context) async {
    try {
      final session = await _authService.getSession();
      ServiceRoute.userId = session.userId;
      ServiceRoute.token = await _authService.getJwt();
      await validacaoPermissao(session.userId);
      unawaited(
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainPage.route,
          (route) => false,
        ),
      );
    } catch (e) {
      Helps.log(e);
    }
  }
}
