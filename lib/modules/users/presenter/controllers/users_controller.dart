import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UsersController extends IController {
  var lista = <User>[];
  final Global global;
  final AppwriteAdmin app;
  var pesquisa = ValueNotifier('');
  var status = ValueNotifier(StatusBuild.loading);

  UsersController({required this.app, required this.global});
  @override
  void dispose() {
    super.dispose();
    status.dispose();
    pesquisa.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaUsers();
  }

  void carregaUsers() async {
    try {
      status.value = StatusBuild.loading;
      lista.clear();
      var retorno = await app.users.list(limit: 100, search: pesquisa.value);
      lista = retorno.users.map((e) => User.fromJson(e.toMap())).toList();
      status.value = StatusBuild.done;
    } catch (e) {
      status.value = StatusBuild.erro;
    }
  }
}
