import 'dart:async';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class PermissoesController extends ManagerStore {
  final UsersRepository _usersRepository;
  final PermissionsRepository _permissionsRepository;

  var permissoes = <Permission>[];
  PermissoesController(
    this._permissionsRepository,
    this._usersRepository,
  );

  @override
  void init(Map<String, dynamic> arguments) {
    carregaPermissoes();
  }

  Future<String> getNameUser({required String userId}) async {
    final result = await _usersRepository.getDocument(id: userId);
    return result?.email ?? 'Não encontrado';
  }

  Future<void> carregaPermissoes() async {
    try {
      state = StateManager.loading;
      permissoes = await _permissionsRepository.listDocument();
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
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
