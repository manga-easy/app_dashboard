import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissions_model.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class EditPermissoesController extends IController {
  final UsersRepository _usersRepository;
  final PermissionsRepository _permissionsRepository;
  EditPermissoesController(
    this._permissionsRepository,
    this._usersRepository,
  );

  Permissions? permissoes;

  @override
  void init(BuildContext context) {
    permissoes = ModalRoute.of(context)!.settings.arguments as Permissions?;
    permissoes ??= Permissions.empty();
    state = StatusBuild.done;
  }

  Future<String> getNameUser({required String userId}) async {
    if (userId.isEmpty) {
      return 'Selecione um usuario';
    }
    final result = await _usersRepository.getDocument(id: userId);
    return result?.name ?? 'Não encontrado';
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
      state = StatusBuild.loading;
      if (permissoes!.userId.isEmpty) {
        throw Exception('User vazio, selecione um usuário');
      }
      var op = 'criado';
      if (permissoes!.id == null) {
        await _permissionsRepository.creatDocument(objeto: permissoes!);
      } else {
        await _permissionsRepository.updateDocument(objeto: permissoes!);
        op = 'atualizado';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Permissão $op com sucesso',
        context: context,
      );
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }

  Future<List<User>> pesquisaUser(String pesquisa) async {
    if (pesquisa.isEmpty) {
      return [];
    }
    return await _usersRepository.listDocument(
      search: pesquisa,
    );
  }
}
