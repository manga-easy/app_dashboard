import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/core_module.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashController extends IController {
  SplashController();

  @override
  void init(BuildContext context) {
    loadingServices(context);
  }

  Future<void> loadingServices(BuildContext context) async {
    try {
      await CoreModule().start();

      context.pushReplacement(
        AuthPage.route,
      );
    } catch (e) {
      Helps.log(e);
      await AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }
}
