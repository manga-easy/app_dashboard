import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UsersController extends IController {
  var lista = ValueNotifier(<User>[]);
  final Global global;
  final AppwriteAdmin app;
  var pesquisa = ValueNotifier('');

  UsersController({required this.app, required this.global});
  @override
  void onClose() {
    lista.dispose();
    pesquisa.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaUsers();
  }

  void carregaUsers() async {
    lista.value.clear();
    var retorno = await app.users.list(limit: 100, search: pesquisa.value);
    lista.value = retorno.users.map((e) => User.fromJson(e.toMap())).toList();
  }
}
