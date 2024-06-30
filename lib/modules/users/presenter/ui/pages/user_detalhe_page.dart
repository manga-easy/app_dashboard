import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/error_default_page.dart';

import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/emblemas_users.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/info_users.dart';
import 'package:flutter/material.dart';

class UserDetalhesPage extends StatefulWidget {
  static const route = '/UserDetalhes';
  const UserDetalhesPage({super.key});
  @override
  State<UserDetalhesPage> createState() => _UserDetalhesPageState();
}

class _UserDetalhesPageState extends State<UserDetalhesPage> {
  final ct = di.get<UsersDetalhesController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.onMessage(listernerMessage);
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        switch (ct.state) {
          case StatusBuild.erro:
            return const ErrorDefaultPage();
          case StatusBuild.initial:
          case StatusBuild.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case StatusBuild.done:
            return Scaffold(
              appBar: AppBar(
                title: Text(ct.user?.name ?? 'Carregando...'),
              ),
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 15,
                      spacing: 15,
                      children: [
                        InfoUsersW(
                          user: ct.user!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    EmblemasUsersW(
                      ct: ct,
                      list: ct.emblemasUsers,
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
