import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends GetView {
  static const router = '/auth';
  final ct = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButtonPadrao(
        title: 'logar',
        icone: Icons.dangerous,
        onPress: ct.logar,
      ),
    );
  }
}
