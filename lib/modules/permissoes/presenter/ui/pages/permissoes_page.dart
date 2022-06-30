import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:flutter/material.dart';

class PermissoesPage extends StatefulWidget {
  static const route = '/Permissoes';
  const PermissoesPage({super.key});
  @override
  State<PermissoesPage> createState() => _PermissoesPageState();
}

class _PermissoesPageState extends State<PermissoesPage> {
  final ct = di.get<PermissoesController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: PermissoesPage.route,
          statusBuild: ct.status.value,
          itemBuilderLista: (context, index) {
            var data = ct.permissoes[index];
            return Card(
              child: ListTile(
                title: NameUserBuild(
                  future: ct.getNameUser(userId: data.userId),
                ),
                subtitle: Text('Nivel: ${data.value}'),
              ),
            );
          },
          listaItems: ct.permissoes,
        );
      },
    );
  }
}
