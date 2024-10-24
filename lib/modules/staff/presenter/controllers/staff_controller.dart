import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/repositories/staff_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class StaffController extends ManagerStore {
  final StaffRepository _staffRepository;
  final UsersRepository _usersRepository;
  List<StaffEntity> staffList = [];
  StaffEntity? staffDetail;

  StaffController(this._staffRepository, this._usersRepository);

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    await getList();
    state = StateManager.done;
  }

  Future<void> getList() async {
    try {
      state = StateManager.loading;
      staffList = await _staffRepository.list();
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
      rethrow;
    }
  }

  Future<void> getById(String id, {int? selectedType}) async {
    final staff = await _staffRepository.getById(id: id);
    if (staff != null) {
      staffDetail = staff;
      selectedType = staffDetail!.type.index;
    }
    notifyListeners();
  }

  Future<void> delete(String id, BuildContext context) async {
    await AppHelps.confirmaDialog(
      title: 'Deseja apagar?',
      content: 'Essa ação removerá este usuário da staff, você confirma?!',
      confime: () async {
        await _staffRepository.delete(id: id);
        Navigator.pop(context);
        await getList();
        notifyListeners();
      },
      context: context,
    );
  }

  String? validateUserName(User? user) {
    if (user?.name != null && user!.name.isNotEmpty) {
      return user.name;
    }
    return user?.email;
  }

  Future<List<User>> findStaff(String staffId) async {
    return _usersRepository.listDocument(
      search: staffId.isEmpty ? null : staffId,
    );
  }

  String convertStaffType(StaffType type) {
    switch (type) {
      case StaffType.admin:
        return 'Admin';
      case StaffType.support:
        return 'Suporte';
      case StaffType.designer:
        return 'Designer';
      case StaffType.developer:
        return 'Desenvolvedor';
      default:
        return 'Não encontrado';
    }
  }
}
