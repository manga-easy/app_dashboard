import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';

class ForbidenPage extends StatelessWidget {
  static const route = '/forbiden';
  const ForbidenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: route,
      error: null,
      state: StateManager.done,
      itemBuilderLista: (context, index) {
        return const Center(
          child: Text('Sem permissão para acessar esse modulo'),
        );
      },
      listaItems: const [1],
    );
  }
}
