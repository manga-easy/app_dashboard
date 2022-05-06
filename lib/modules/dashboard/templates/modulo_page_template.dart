import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModuloPageTemplate extends StatelessWidget {
  final String route;
  final ValueListenable<StatusBuild> valueListenable;
  final void Function()? onPressedAtualiza;
  final void Function()? onPressedNovoItem;
  final String labelNovoItem;
  final Function(String)? onChangePesquisa;
  final void Function()? onEditCompletPesquisa;
  final List listaItems;
  final Widget Function(BuildContext, int) itemBuilderLista;

  const ModuloPageTemplate({
    Key? key,
    required this.route,
    required this.valueListenable,
    this.onPressedAtualiza,
    this.onPressedNovoItem,
    required this.labelNovoItem,
    required this.itemBuilderLista,
    required this.listaItems,
    this.onChangePesquisa,
    this.onEditCompletPesquisa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(atual: route),
      appBar: AppBar(),
      body: SafeArea(
        child: ValueListenableBuilder<StatusBuild>(
          valueListenable: valueListenable,
          builder: (context, value, child) {
            if (value == StatusBuild.loading) {
              return const LoadingAtom();
            }
            return Column(
              children: [
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: onPressedAtualiza, child: const Text('Atualiza')),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.defaultPadding * 1.5,
                          vertical: AppTheme.defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: onPressedNovoItem,
                      icon: const Icon(Icons.add),
                      label: Text(labelNovoItem),
                    ),
                  ],
                ),
                CampoPadraoAtom(
                  onChange: onChangePesquisa,
                  onEditComplet: onEditCompletPesquisa,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listaItems.length,
                    itemBuilder: itemBuilderLista,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
