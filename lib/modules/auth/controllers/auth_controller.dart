import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repositories/crendecial_repository.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/main_screen.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissoes_params.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart'
    as sdk;
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
  void init(BuildContext context) {
    loginAutomatico(context);
    carregaCredencial();
  }

  Future<void> logar(context) async {
    try {
      await checkUsuario();
      final user = await _authService.getUser();
      await validacaoPermissao(user);
      ServiceRoute.user = sdk.User.fromJson(user.toMap());
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

  Future<Session> checkUsuario() async {
    return _authService.createSession(
      email: email.text,
      password: password.text,
    );
  }

  Future<void> validacaoPermissao(User response) async {
    final result = await _permissionsRepository.listDocument(
        where: PermissoesParams(
      userId: response.$id,
    ));

    _serviceRoute.permissions = result.first;
  }

  void carregaCredencial() {
    final ret = _credencialRepo.list();
    if (ret.isNotEmpty) {
      credencialModel = ret.first;
      email.text = credencialModel!.email;
    }
  }

  Future<void> salvaCredencial() async {
    final cred = CredencialModel(
      datetime: DateTime.now(),
      email: email.text,
    );
    await _credencialRepo.put(objeto: cred);
  }

  Future<void> loginAutomatico(context) async {
    try {
      final dataUser = await _authService.getUser();
      await validacaoPermissao(dataUser);
      ServiceRoute.user = sdk.User.fromJson(dataUser.toMap());
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
