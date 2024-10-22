import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/staff/data/dtos/staff_dto.dart';
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
  String? staffId;
  int? selectedType;

  StaffController(this._staffRepository, this._usersRepository);

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    staffId = arguments['id'];
    if (staffId != null && staffId != 'create') {
      await getById(staffId!);
    } else {
      await getList();
    }
    state = StateManager.done;
  }

  Future<void> getList() async {
    staffList = await _staffRepository.list();
    notifyListeners();
  }

  Future<void> getById(String id) async {
    final staff = await _staffRepository.getById(id: id);
    if (staff.isNotEmpty) {
      staffDetail = staff.first;
      selectedType = staffDetail!.type.index;
    }
    notifyListeners();
  }

  Future<void> assignUser(String userId) async {
    staffDetail = staffDetail?.copyWith(userId: userId);
    notifyListeners();
  }

  Future<void> saveEditStaff(BuildContext context) async {
    if (staffDetail == null || staffDetail!.userId.isEmpty) {
      throw Exception('User vazio, selecione um usuário');
    }

    final staffDto = StaffDto.fromEntity(staffDetail!);

    if (staffId == 'create') {
      await _staffRepository.post(body: staffDto);
    } else {
      await _staffRepository.put(id: staffId!, body: staffDto);
    }

    Navigator.of(context).pop();
    await AppHelps.confirmaDialog(
      title: 'Sucesso',
      content: 'Staff salvo com sucesso!',
      context: context,
    );
  }

  Future<List<User>> findStaff(String staff) async {
    return _usersRepository.listDocument(search: staff.isEmpty ? null : staff);
  }

  Future<String> getEmail({required String userId}) async {
    if (userId.isEmpty) {
      return 'Selecione um usuario';
    }
    final result = await _usersRepository.getDocument(id: userId);
    return result?.email ?? 'Não encontrado';
  }

  Future<void> delete(String id) async {
    await _staffRepository.delete(id: id);
    await getList();
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
