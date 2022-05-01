import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';

class MenuController extends IController {
  final Global global;
  var page = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MenuController({required this.global});

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void trocarPage(int v, BuildContext context) {
    page.value = v;
    Navigator.of(context).pop();
  }

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    global.validaLogin(context);
  }
}
