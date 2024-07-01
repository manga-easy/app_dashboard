import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';
import 'package:flutter/material.dart';

class HostController extends IController {
  final HostRepositoryV1 _hostRepository;

  HostController(this._hostRepository);

  var list = <HostEntity>[];

  @override
  void init(BuildContext context) {
    loadingHost();
  }

  Future<void> loadingHost() async {
    try {
      list = await _hostRepository.listDocument();
      state = StatusBuild.done;
    } on Exception catch (e) {
      handleErrorEvent(e);
      state = StatusBuild.erro;
    }
  }

  Future<void> changStatus(HostEntity host) async {
    try {
      state = StatusBuild.loading;
      host.status = host.status == HostStatus.disable
          ? HostStatus.enable
          : HostStatus.disable;
      await _hostRepository.updateDocument(objeto: host.toDto(), id: host.id);
      list = await _hostRepository.listDocument();
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }
}
