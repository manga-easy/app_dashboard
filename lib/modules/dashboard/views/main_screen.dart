import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/total_adquirido_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/detalhes_emblemas_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const route = '/Main';
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ct = di.get<DashboardController>();

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
    return ModuloPageTemplate(
      route: MainPage.route,
      statusBuild: ct.status.value,
      itemBuilderLista: (context, inte) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppTheme.defaultPadding),
            Row(
              children: [
                Text(
                  'Emblemas de Doações',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.defaultPadding / 2),
            ValueListenableBuilder(
              valueListenable: ct.emblemasDoadores,
              builder: (context, value, child) {
                return Wrap(
                  children: ct.emblemasDoadores.value
                      .map((e) => InkWell(
                            hoverColor: Colors.white,
                            onTap: () => Navigator.pushNamed(
                              context,
                              DetalhesEmblemasPage.route,
                              arguments: e,
                            ),
                            child: Container(
                              width: 150,
                              height: 150,
                              color: AppTheme.secondaryColor,
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.name),
                                  TotalAdquiridoAtom(future: ct.calculaTotalAdquirido(e.id!)),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        );
      },
      listaItems: const [1],
    );
  }
}
