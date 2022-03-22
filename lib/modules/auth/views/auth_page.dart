import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends GetView {
  static const router = '/auth';
  final ct = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        CampoPadrao(hintText: 'E-mail'),
        SizedBox(height: 10),
        CampoPadrao(hintText: 'Senha'),
        SizedBox(height: 10),
        ButtonPadrao(
          title: 'logar',
          icone: Icons.dangerous,
          onPress: ct.logar,
        ),
      ],
    ));
  }
}
