import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  var page = 0.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  trocarPage(int v) {
    page.value = v;
    Get.back();
  }
}
