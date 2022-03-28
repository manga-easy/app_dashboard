import 'package:dashboard_manga_easy/core/config/app_theme.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding * 2,
          vertical: AppTheme.defaultPadding * 2,
        ),
        child: Container(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.secondaryColor,
          ),
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: AppTheme.defaultPadding * 2),
              CampoPadrao(
                hintText: 'E-mail',
                controller: ct.email,
              ),
              SizedBox(height: AppTheme.defaultPadding),
              CampoPadrao(
                hintText: 'Senha',
                controller: ct.password,
                obscureText: true,
              ),
              SizedBox(height: AppTheme.defaultPadding * 2),
              ButtonPadrao(
                title: 'logar',
                icone: Icons.login,
                onPress: () => ct.logar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
