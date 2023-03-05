import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class PermissoesController extends IController {
  final PermissoesRepository permissoesRepository;
  final AppwriteAdmin appwriteAdmin;
  var permissoes = <Permissions>[];
  PermissoesController({
    required this.appwriteAdmin,
    required this.permissoesRepository,
  });

  @override
  void init(BuildContext context) {
    carregaPermissoes();
  }

  Future<String> getNameUser({required String userId}) async {
    var ret = await appwriteAdmin.users.get(userId: userId);
    return ret.name;
  }

  void carregaPermissoes() async {
    state = StatusBuild.loading;
    var ret = await permissoesRepository.listDocument();
    permissoes = ret.data;
    state = StatusBuild.done;
  }

  Future<void> removePermissoes(String id, context) async {
    var ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: 'removerá as permissões do usuario',
      context: context,
    );
    if (ret) {
      await permissoesRepository.deletDocument(id: id);
      carregaPermissoes();
    }
  }
}
