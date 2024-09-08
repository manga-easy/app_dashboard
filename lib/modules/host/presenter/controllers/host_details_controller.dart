import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/create_host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class HostDetailsController extends ManagerStore {
  final HostRepositoryV1 _hostRepository;

  HostDetailsController(this._hostRepository);

  CreateHostDto dto = CreateHostDto.empty();
  String? id;

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    if (arguments['id'] != 'create') {
      id = arguments['id'];
      final result = await _hostRepository.getDocument(id: id!);
      if (result != null) {
        dto = CreateHostDto.fromEntity(result);
      }
    }
    state = StateManager.done;
  }

  Future<void> saveHost(BuildContext context) => handleTry(
        call: () async {
          if (id == null) {
            await _hostRepository.creatDocument(objeto: dto);
          } else {
            await _hostRepository.updateDocument(objeto: dto, id: id!);
          }
          Navigator.pop(context);
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Host salvo com sucesso',
            context: context,
          );
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );
}
