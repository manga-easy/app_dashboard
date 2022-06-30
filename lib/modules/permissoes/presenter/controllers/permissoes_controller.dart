import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/repositories/permissoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class PermissoesController extends IController {
  final PermissoesRepository permissoesRepository;
  final AppwriteAdmin appwriteAdmin;
  var status = ValueNotifier(StatusBuild.loading);
  var permissoes = <Permissions>[];
  PermissoesController({
    required this.appwriteAdmin,
    required this.permissoesRepository,
  });

  @override
  void onClose() {
    status.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaPermissoes();
    var arguments = ModalRoute.of(context)!.settings.arguments;
  }

  Future<String> getNameUser({required String userId}) async {
    var ret = await appwriteAdmin.users.get(userId: userId);
    return ret.name;
  }

  void carregaPermissoes() async {
    var ret = await permissoesRepository.listDocument();
    permissoes = ret.data;
    status.value = StatusBuild.done;
  }
}
