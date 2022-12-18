import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/delete_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/list_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/update_host_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostController extends IController {
  final ListHostCase listHostCase;
  final DeleteHostCase deleteHostCase;
  final UpdateHostCase updateHostCase;

  HostController({
    required this.listHostCase,
    required this.deleteHostCase,
    required this.updateHostCase,
  });

  var status = StatusBuild.loading;
  var list = <HostModel>[];

  @override
  void init(BuildContext context) {
    loadingHost();
  }

  Future<void> loadingHost() async {
    try {
      list = await listHostCase();
      status = StatusBuild.done;
    } catch (e) {
      Helps.log(e);
      status = StatusBuild.erro;
    }
    notifyListeners();
  }

  Future<void> deleteHost(BuildContext context, HostModel host) async {
    try {
      status = StatusBuild.loading;
      notifyListeners();
      await deleteHostCase(host);
      list = await listHostCase();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Host salvo com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Error',
        content: e.toString(),
        context: context,
      );
    }
    status = StatusBuild.done;
    notifyListeners();
  }

  Future<void> changStatus(HostModel host) async {
    try {
      status = StatusBuild.loading;
      notifyListeners();
      host.status = host.status == HostStatus.disable
          ? HostStatus.enable
          : HostStatus.disable;
      await updateHostCase(host);
      list = await listHostCase();
    } catch (e) {
      Helps.log(e);
    }
    status = StatusBuild.done;
    notifyListeners();
  }
}
