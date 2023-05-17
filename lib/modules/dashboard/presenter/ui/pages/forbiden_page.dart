
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';

class ForbidenPage extends StatefulWidget {
  static const route = '/Forbiden';
  const ForbidenPage({Key? key}) : super(key: key);
  @override
  State<ForbidenPage> createState() => _ForbidenPageState();
}

class _ForbidenPageState extends State<ForbidenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: ForbidenPage.route,
      statusBuild: StatusBuild.done,
      itemBuilderLista: (context, index) {
        return const Center(
          child: Text('Sem permissão para acessar esse modulo'),
        );
      },
      listaItems: const [1],
    );
  }
}
