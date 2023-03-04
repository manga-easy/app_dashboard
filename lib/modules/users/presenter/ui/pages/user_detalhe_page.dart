
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/main.dart';

import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/card_xp_user.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/emblemas_users.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/info_users.dart';
import 'package:flutter/material.dart';

class UserDetalhesPage extends StatefulWidget {
  static const route = '/UserDetalhes';
  const UserDetalhesPage({Key? key}) : super(key: key);
  @override
  State<UserDetalhesPage> createState() => _UserDetalhesPageState();
}

class _UserDetalhesPageState extends State<UserDetalhesPage> {
  final ct = di.get<UsersDetalhesController>();

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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        if (ct.status.value == StatusBuild.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
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
                      onPress: () => ct.addNotificacao(context),
                    ),
                    CardXpUser(
                      ct: ct,
                    )
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
      },
    );
  }
}
