import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  static const route = '/auth';
  const AuthPage({Key? key}) : super(key: key);
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final ct = di.get<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

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
                onPress: () => ct.logar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
