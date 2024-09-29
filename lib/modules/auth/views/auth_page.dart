import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/auth/controllers/auth_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/versao_app_org.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_page.dart';

class AuthPage extends StatefulWidget {
  static const route = '/auth';
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ManagerPage<AuthController, AuthPage> {
  @override
  void initState() {
    ct.onNavigation((event) => context.pushReplacement(event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ct.state != StateManager.done) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 8),
                  VersaoAppOrg(),
                ],
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
