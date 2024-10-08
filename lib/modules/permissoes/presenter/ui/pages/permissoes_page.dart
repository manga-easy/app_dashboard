import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class PermissoesPage extends StatefulWidget {
  static const route = '/permissions';
  const PermissoesPage({super.key});
  @override
  State<PermissoesPage> createState() => _PermissoesPageState();
}

class _PermissoesPageState
    extends ManagerPage<PermissoesController, PermissoesPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: PermissoesPage.route,
      error: ct.error,
      state: ct.state,
      onPressedAtualiza: ct.carregaPermissoes,
      labelNovoItem: 'Adicionar permissão',
      onPressedNovoItem: () => context.push('${PermissoesPage.route}/create'),
      itemBuilderLista: (context, index) {
        final data = ct.permissoes[index];
        return Card(
          child: ListTile(
            onTap: () => context
                .push('${PermissoesPage.route}/${data.id}')
                .then((value) => ct.carregaPermissoes()),
            title: NameUserBuild(
              future: ct.getNameUser(userId: data.userId),
            ),
            subtitle: Text(
              'Nivel: ${data.level}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () => ct.removePermissoes(data.id, context),
            ),
          ),
        );
      },
      listaItems: ct.permissoes,
    );
  }
}
