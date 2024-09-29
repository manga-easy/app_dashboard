import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/toggles/domain/entities/toggle_entity.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/controllers/toggle_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class TogglesPage extends StatefulWidget {
  static const route = '/toggle';
  const TogglesPage({super.key});
  @override
  State<TogglesPage> createState() => _TogglesPageState();
}

class _TogglesPageState extends ManagerPage<ToggleController, TogglesPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: TogglesPage.route,
      error: ct.error,
      state: ct.state,
      labelNovoItem: 'Novo Toggle',
      onPressedAtualiza: ct.listToggles,
      itemBuilderLista: (context, index) {
        final ToggleEntity toggle = ct.toggles[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  toggle.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  toggle.value.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonPadraoAtom(
                    title: 'Editar',
                    icone: Icons.edit,
                    onPress: () => context.go(
                      '${TogglesPage.route}/${toggle.name}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      listaItems: ct.toggles,
      onPressedNovoItem: () => context.go('${TogglesPage.route}/create'),
    );
  }
}
