import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/create_host_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/usercases/update_host_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostDetailsController extends IController {
  final CreateHostCase createHostCase;
  final UpdateHostCase updateHostCase;

  HostDetailsController({
    required this.createHostCase,
    required this.updateHostCase,
  });

  HostModel? host;
  var status = StatusBuild.loading;

  @override
  void init(BuildContext context) {
    host = ModalRoute.of(context)!.settings.arguments as HostModel?;
    host ??= HostModel.empty();
    status = StatusBuild.done;
    notifyListeners();
  }

  Future<void> saveHost(BuildContext context) async {
    try {
      status = StatusBuild.loading;
      notifyListeners();
      if (host!.id == null) {
        await createHostCase(host!);
      } else {
        await updateHostCase(host!);
      }
      Navigator.pop(context);
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
}
