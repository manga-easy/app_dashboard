import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';

class DashboardController extends IController {
  final AppwriteAdmin app;
  final Global global;

  DashboardController({required this.app, required this.global});

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    global.validaLogin(context);
  }
}
