import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/emblemas_users.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/info_users.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class UserDetalhesPage extends StatefulWidget {
  const UserDetalhesPage({super.key});
  @override
  State<UserDetalhesPage> createState() => _UserDetalhesPageState();
}

class _UserDetalhesPageState
    extends ManagerPage<UsersDetalhesController, UserDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      error: ct.error,
      state: ct.state,
      appBar: Text(ct.user?.name ?? 'Carregando...'),
      pageDone: () {
        return ListView(
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
        );
      },
    );
  }
}
