import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/informacoes_user_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/controllers/detalhes_emblemas_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';

class DetalhesEmblemasPage extends StatefulWidget {
  static const route = '/DetalhesEmblemas';
  const DetalhesEmblemasPage({Key? key}) : super(key: key);
  @override
  State<DetalhesEmblemasPage> createState() => _DetalhesEmblemasPageState();
}

class _DetalhesEmblemasPageState extends State<DetalhesEmblemasPage> {
  final ct = di.get<DetalhesEmblemasController>();

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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: DetalhesEmblemasPage.route,
          statusBuild: ct.status.value,
          itemBuilderLista: (context, index) {
            var e = ct.lista[index];
            return Row(
              children: [
                Text(e.userId),
                const SizedBox(width: 10),
                InformacoesUserAtom(future: ct.getUser(e.userId)),
              ],
            );
          },
          listaItems: ct.lista,
        );
      },
    );
  }
}
