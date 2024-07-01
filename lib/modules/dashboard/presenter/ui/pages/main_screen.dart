import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const route = '/Main';
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ct = di.get<DashboardController>();

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
          ],
        );
      },
      listaItems: const [1],
    );
  }
}
