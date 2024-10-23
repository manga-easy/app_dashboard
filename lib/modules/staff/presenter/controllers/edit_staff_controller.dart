import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/staff/data/dtos/staff_dto.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/repositories/staff_repository.dart';
import 'package:dashboard_manga_easy/modules/staff/presenter/controllers/staff_controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class EditStaffController extends ManagerStore {
  final StaffController _staffController;
  final StaffRepository _staffRepository;
  final UsersRepository _usersRepository;

  StaffEntity? staffDetail;
  String? staffId;
  int? selectedType;

  String appBarText = 'Criar Staff';
  bool blockNewStaff = false;

  EditStaffController(
    this._staffController,
    this._staffRepository,
    this._usersRepository,
  );

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    staffId = arguments['id'];
    if (staffId != null && staffId != 'create') {
      appBarText = 'Editar Staff';
      blockNewStaff = true;

      final result = await _staffRepository.getById(id: staffId!);
      staffDetail = result.isNotEmpty ? result.first : null;

      if (staffDetail != null) {
        selectedType = staffDetail!.type.index;
      }
    } else {
      staffDetail = StaffEntity.empty();
    }
    state = StateManager.done;
    notifyListeners();
  }

  Future<void> assignUser(String userId) async {
    if (staffDetail != null) {
      staffDetail = staffDetail!.copyWith(userId: userId);
      notifyListeners();
    }
  }

  String convertStaffType(StaffType type) {
    return _staffController.convertStaffType(type);
  }

  Future<void> saveEditStaff(BuildContext context) => handleTry(
        call: () async {
          if (staffDetail == null || staffDetail!.userId.isEmpty) {
            await AppHelps.confirmaDialog(
              title: 'Insira um valor válido!',
              context: context,
            );
            return;
          }

          final staffDto = StaffDto.fromEntity(staffDetail!);

          if (staffId == 'create') {
            await _staffRepository.post(body: staffDto);
            Navigator.of(context).pop();
            await AppHelps.confirmaDialog(
              title: 'Sucesso',
              content: 'Staff salvo com sucesso!',
              context: context,
            );
            return;
          } else {
            if (!await _verifyStaffHasRole(staffDto)) {
              await _staffRepository.put(id: staffId!, body: staffDto);
              Navigator.of(context).pop();
              await AppHelps.confirmaDialog(
                title: 'Sucesso',
                content: 'Staff salvo com sucesso!',
                context: context,
              );
            } else {
              await AppHelps.confirmaDialog(
                title: 'O Usuário já possui este cargo.',
                context: context,
              );
            }
          }
        },
        onCatch: StateManager.done,
        showDialogError: true,
      );

  void updateStaffType(int? typeIndex) {
    if (typeIndex != null && staffDetail != null) {
      staffDetail = staffDetail!.copyWith(type: StaffType.values[typeIndex]);
    }
  }

  Future<bool> _verifyStaffHasRole(StaffDto staff) async {
    final List<StaffEntity> roles =
        await _staffRepository.getByUserId(userId: staff.userId);

    return roles
        .any((role) => role.type == StaffDto.mapStringToStaffType(staff.type));
  }

  Future<List<User>> findStaff(String staff) async {
    return _staffController.findStaff(staff);
  }

  Future<String> getEmail({required String userId}) async {
    if (userId.isEmpty) {
      return 'ID inválido';
    }
    final result = await _usersRepository.getDocument(id: userId);
    return result?.email ?? 'Não encontrado';
  }
}
