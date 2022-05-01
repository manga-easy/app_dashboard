import 'package:dashboard_manga_easy/core/services/service.dart';
import 'package:dashboard_manga_easy/modules/auth/views/auth_page.dart';
import 'package:flutter/material.dart';

enum StatusBuild { done, loading, erro }

class Global extends IService {
  String? user;
  Future<Global> inicia() async {
    return this;
  }

  @override
  Future<void> initialise() async {}

  void validaLogin(context) {
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthPage.route,
        (route) => true,
      );
    }
  }
}
