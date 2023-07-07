import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UsersController extends IController {
  var lista = <User>[];

  var pesquisa = ValueNotifier('');

  UsersController();

  @override
  void dispose() {
    super.dispose();
    pesquisa.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaUsers();
  }

  Future<void> carregaUsers() async {
    try {
      state = StatusBuild.loading;
      lista.clear();
      throw UnimplementedError();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
    }
  }
}
