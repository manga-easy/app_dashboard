import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/create_permission_dto.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class EditPermissoesController extends ManagerStore {
  final UsersRepository _usersRepository;
  final PermissionsRepository _permissionsRepository;
  EditPermissoesController(
    this._permissionsRepository,
    this._usersRepository,
  );

  CreatePermissionDto permission = CreatePermissionDto.empty();
  String? id;
  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    if (arguments['id'] != 'create') {
      id = arguments['id'];
      final result = await _permissionsRepository.getDocument(id: id!);
      if (result != null) {
        permission = CreatePermissionDto.fromEntity(result);
      }
    }

    state = StateManager.done;
  }

  Future<String> getEmail({required String userId}) async {
    if (userId.isEmpty) {
      return 'Selecione um usuario';
    }
    final result = await _usersRepository.getDocument(id: userId);
    return result?.email ?? 'Não encontrado';
  }

  Future<void> salvarEditaDados(BuildContext context) => handleTry(
        call: () async {
          if (permission.userId.isEmpty) {
            throw Exception('User vazio, selecione um usuário');
          }
          var op = 'criado';

          if (id == null) {
            await _permissionsRepository.creatDocument(
              objeto: permission,
            );
          } else {
            await _permissionsRepository.updateDocument(
              objeto: permission,
              id: id!,
            );
            op = 'atualizado';
          }

          Navigator.of(context).pop();
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Permissão $op com sucesso',
            context: context,
          );
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );

  Future<List<User>> pesquisaUser(String pesquisa) async {
    if (pesquisa.isEmpty) {
      return [];
    }
    return await _usersRepository.listDocument(
      search: pesquisa,
    );
  }
}
