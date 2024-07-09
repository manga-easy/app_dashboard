import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class UsersController extends ManagerStore {
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
  void init(Map<String, dynamic> arguments) {
    carregaUsers();
  }

  Future<void> carregaUsers() async {
    try {
      state = StateManager.loading;
      lista = await _usersRepository.listDocument(
        search: pesquisa.value.isEmpty ? null : pesquisa.value,
      );
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
      rethrow;
    }
  }
}
