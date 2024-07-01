import 'dart:async';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class PermissoesController extends IController {
  final UsersRepository _usersRepository;
  final PermissionsRepository _permissionsRepository;

  var permissoes = <Permission>[];
  PermissoesController(
    this._permissionsRepository,
    this._usersRepository,
  );

  @override
  void init(BuildContext context) {
    carregaPermissoes();
  }

  Future<String> getNameUser({required String userId}) async {
    final result = await _usersRepository.getDocument(id: userId);
    return result?.email ?? 'Não encontrado';
  }

  Future<void> carregaPermissoes() async {
    try {
      state = StatusBuild.loading;
      permissoes = await _permissionsRepository.listDocument();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
      rethrow;
    }
  }

  Future<void> removePermissoes(String id, context) async {
    final ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: 'removerá as permissões do usuario',
      context: context,
    );
    if (ret) {
      await _permissionsRepository.deletDocument(id: id);
      unawaited(carregaPermissoes());
    }
  }
}
