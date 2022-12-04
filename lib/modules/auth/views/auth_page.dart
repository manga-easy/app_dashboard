import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding * 2,
          vertical: AppTheme.defaultPadding * 2,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: AppTheme.defaultPadding * 2),
              CampoPadraoAtom(
                hintText: 'E-mail',
                controller: ct.email,
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              CampoPadraoAtom(
                hintText: 'Senha',
                controller: ct.password,
                obscureText: true,
                onSubmitted: (v) => ct.logar(context),
              ),
              const SizedBox(height: AppTheme.defaultPadding * 2),
              ButtonPadraoAtom(
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
