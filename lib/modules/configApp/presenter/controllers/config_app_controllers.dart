import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class ConfigAppController extends IController {
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;

  ConfigAppController({
    required this.getConfigAppCase,
    required this.upConfigAppCase,
  });

  var status = StatusBuild.loading;
  var config = ConfigAppModel.offline();

  @override
  void init(BuildContext context) {
    loadingConfig();
  }

  Future<void> loadingConfig() async {
    try {
      config = await getConfigAppCase();
      status = StatusBuild.done;
    } catch (e) {
      Helps.log(e);
      status = StatusBuild.erro;
    }
    notifyListeners();
  }

  Future<void> updateConfig(BuildContext context) async {
    try {
      await upConfigAppCase(config);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Config atualizado com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }
}
