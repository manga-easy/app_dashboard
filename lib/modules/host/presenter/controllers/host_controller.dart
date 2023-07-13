import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostController extends IController {
  final HostRepository _hostRepository;

  HostController(this._hostRepository);

  var list = <HostModel>[];

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

  Future<void> deleteHost(BuildContext context, HostModel host) async {
    try {
      state = StatusBuild.loading;
      await _hostRepository.deletDocument(id: host.id!);
      list = await _hostRepository.listDocument();
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

  Future<void> changStatus(HostModel host) async {
    try {
      state = StatusBuild.loading;
      host.status = host.status == HostStatus.disable
          ? HostStatus.enable
          : HostStatus.disable;
      await _hostRepository.updateDocument(objeto: host);
      list = await _hostRepository.listDocument();
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }
}
