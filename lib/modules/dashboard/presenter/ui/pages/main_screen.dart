import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class MainPage extends StatefulWidget {
  static const route = '/';
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ManagerPage<DashboardController, MainPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: MainPage.route,
      state: ct.state,
      error: ct.error,
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
          ],
        );
      },
      listaItems: const [1],
    );
  }
}
