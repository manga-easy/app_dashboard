import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/user_detalhe_page.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  static const route = '/Users';
  const UsersPage({super.key});
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final ct = di.get<UsersController>();

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
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        return ModuloPageTemplate(
          route: UsersPage.route,
          statusBuild: ct.state,
          listaItems: ct.lista,
          initialValueCampoPesquisa: ct.pesquisa.value,
          onChangePesquisa: (p) => ct.pesquisa.value = p,
          onEditCompletPesquisa: ct.carregaUsers,
          onPressedAtualiza: ct.carregaUsers,
          itemBuilderLista: (context, index) {
            final User use = ct.lista[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, UserDetalhesPage.route,
                  arguments: use,),
              leading: CircleAvatar(
                radius: 35,
                child: Text(use.name.substring(0, use.name.length > 1 ? 1 : 0)),
              ),
              title: Text(use.name),
              subtitle: Text(
                use.email,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }
}
