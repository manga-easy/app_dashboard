import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class UsersPage extends StatefulWidget {
  static const route = '/users';
  const UsersPage({super.key});
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ManagerPage<UsersController, UsersPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: UsersPage.route,
      error: ct.error,
      state: ct.state,
      listaItems: ct.lista,
      initialValueCampoPesquisa: ct.pesquisa.value,
      onChangePesquisa: (p) => ct.pesquisa.value = ct.removeGmailSearch(p),
      onEditCompletPesquisa: ct.carregaUsers,
      onPressedAtualiza: ct.carregaUsers,
      itemBuilderLista: (context, index) {
        final User user = ct.lista[index];
        return ListTile(
          onTap: () => context.push(
            '${UsersPage.route}/${user.id}',
          ),
          leading: CircleAvatar(
            radius: 35,
            child: Text(user.name.substring(0, user.name.length > 1 ? 1 : 0)),
          ),
          title: Text(user.name),
          subtitle: Text(
            user.email,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        );
      },
    );
  }
}
