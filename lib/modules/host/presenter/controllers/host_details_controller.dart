import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/create_host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class HostDetailsController extends ManagerStore {
  final HostRepositoryV1 _hostRepository;

  HostDetailsController(this._hostRepository);

  CreateHostDto dto = CreateHostDto.empty();
  HostEntity? host;

  @override
  void init(Map<String, dynamic> arguments) {
    host = arguments as HostEntity?;
    if (host != null) {
      dto = CreateHostDto(
        hostId: host!.hostId,
        order: host!.order,
        name: host!.name,
        urlApi: host!.urlApi,
        status: host!.status,
      );
    }
    state = StateManager.done;
  }

  Future<void> saveHost(BuildContext context) => handleTry(
        call: () async {
          if (host?.id == null) {
            await _hostRepository.creatDocument(objeto: dto);
          } else {
            await _hostRepository.updateDocument(objeto: dto, id: host!.id);
          }
          Navigator.pop(context);
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Host salvo com sucesso',
            context: context,
          );
        },
      );
}
