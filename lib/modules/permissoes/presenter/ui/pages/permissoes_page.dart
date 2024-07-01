import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/pages/edit_permissoes_page.dart';
import 'package:flutter/material.dart';

class PermissoesPage extends StatefulWidget {
  static const route = '/permissions';
  const PermissoesPage({super.key});
  @override
  State<PermissoesPage> createState() => _PermissoesPageState();
}

class _PermissoesPageState extends State<PermissoesPage> {
  final ct = di.get<PermissoesController>();

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
          route: PermissoesPage.route,
          statusBuild: ct.state,
          onPressedAtualiza: ct.carregaPermissoes,
          labelNovoItem: 'Adicionar permissão',
          onPressedNovoItem: () => Navigator.pushNamed(
            context,
            EditPermissoesPage.route,
          ),
          itemBuilderLista: (context, index) {
            final data = ct.permissoes[index];
            return Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  EditPermissoesPage.route,
                  arguments: data,
                ).then((value) => ct.carregaPermissoes()),
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
      },
    );
  }
}
