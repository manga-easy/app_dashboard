import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repository_external.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissoes_repository.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/edit_permissoes_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EditPermissoesController extends ValueNotifier implements IController {
  final UserRepositoryExternal userRepo;
  final PermissoesRepository permissoesRepository;
  final AppwriteAdmin appwriteAdmin;
  Permissions? permissoes;
  EditPermissoesController({
    required this.appwriteAdmin,
    required this.permissoesRepository,
    required this.userRepo,
  }) : super(null);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void init(BuildContext context) {
    permissoes = ModalRoute.of(context)!.settings.arguments as Permissions?;
    permissoes ??= Permissions(
      userId: '',
      value: LevelPermissoes.autor.value,
    );
    notifyListeners();
  }

  Future<String> getNameUser({required String userId}) async {
    if (userId.isEmpty) return 'Sem user';
    var ret = await appwriteAdmin.users.get(userId: userId);
    return ret.name;
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
      if (permissoes!.userId.isEmpty) {
        throw Exception('User vazio, selecione um usuário');
      }
      var op = 'criado';
      if (permissoes!.id == null) {
        await permissoesRepository.creatDocument(objeto: permissoes!);
      } else {
        await permissoesRepository.updateDocument(objeto: permissoes!);
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
    return await userRepo.list(search: pesquisa);
  }
}
