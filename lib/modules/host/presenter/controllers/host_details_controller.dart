import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/host/data/dtos/create_host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:flutter/material.dart';

class HostDetailsController extends IController {
  final HostRepositoryV1 _hostRepository;

  HostDetailsController(this._hostRepository);

  CreateHostDto dto = CreateHostDto.empty();
  HostEntity? host;

  @override
  void init(BuildContext context) {
    host = ModalRoute.of(context)?.settings.arguments as HostEntity?;
    if (host != null) {
      dto = CreateHostDto(
        hostId: host!.hostId,
        order: host!.order,
        name: host!.name,
        urlApi: host!.urlApi,
        status: host!.status.name,
      );
    }
    state = StatusBuild.done;
  }

  Future<void> saveHost(BuildContext context) async {
    try {
      state = StatusBuild.loading;
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
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }
}
