import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissions_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditPermissoesController extends IController {
  final PermissionsRepository _permissionsRepository;
  EditPermissoesController(this._permissionsRepository);

  Permissions? permissoes;

  @override
  void init(BuildContext context) {
    permissoes = ModalRoute.of(context)!.settings.arguments as Permissions?;
    permissoes ??= Permissions.empty();
    notifyListeners();
  }

  Future<String> getNameUser({required String userId}) async {
    if (userId.isEmpty) return 'Sem user';
    throw UnimplementedError();
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
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
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
  }

  Future<List<User>> pesquisaUser(String pesquisa) async {
    throw UnimplementedError();
  }
}
