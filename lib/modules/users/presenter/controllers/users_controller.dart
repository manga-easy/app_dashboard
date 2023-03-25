import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UsersController extends IController {
  var lista = <User>[];

  final AppwriteAdmin app;
  var pesquisa = ValueNotifier('');

  UsersController({required this.app});
  @override
  void dispose() {
    super.dispose();
    pesquisa.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaUsers();
  }

  void carregaUsers() async {
    try {
      state = StatusBuild.loading;
      lista.clear();
      var retorno = await app.users.list(limit: 100, search: pesquisa.value);
      lista = retorno.users.map((e) => User.fromJson(e.toMap())).toList();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
    }
  }
}
