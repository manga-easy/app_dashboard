import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:flutter/material.dart';

class DashboardController extends IController {
  final AppwriteAdmin app;

  DashboardController({required this.app});

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {}
}
