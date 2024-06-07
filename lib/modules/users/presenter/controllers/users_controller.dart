import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class UsersController extends IController {
  final UsersRepository _usersRepository;
  UsersController(this._usersRepository);

  List<User> lista = <User>[];

  ValueNotifier<String> pesquisa = ValueNotifier<String>('');

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
      lista = await _usersRepository.listDocument(
        search: pesquisa.value.isEmpty ? null : pesquisa.value,
      );
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
      rethrow;
    }
  }
}
