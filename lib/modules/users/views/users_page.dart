import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/views/user_detalhe_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UsersPage extends StatefulWidget {
  static const route = '/Users';
  const UsersPage({Key? key}) : super(key: key);
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final ct = di.get<UsersController>();

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
    return Column(
      children: [
        const SizedBox(height: AppTheme.defaultPadding),
        CampoPadraoAtom(
          onChange: (p) => ct.pesquisa.value = p,
          onEditComplet: () => ct.carregaUsers(),
        ),
        const SizedBox(height: AppTheme.defaultPadding),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: ct.lista,
            builder: (context, value, child) => ct.lista.value.isNotEmpty
                ? ListView.builder(
                    itemCount: ct.lista.value.length,
                    itemBuilder: (context, index) {
                      User use = ct.lista.value[index];
                      return ListTile(
                        onTap: () => Navigator.pushNamed(context, UserDetalhesPage.route, arguments: use),
                        leading: CircleAvatar(
                          radius: 35,
                          child: Text(use.name.substring(0, use.name.length > 1 ? 1 : 0)),
                        ),
                        title: Text(use.name),
                        subtitle: Text(
                          use.email,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                        ),
                      );
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
