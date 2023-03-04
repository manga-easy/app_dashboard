import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';

import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';

import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/side_menu.dart';

import 'package:flutter/material.dart';

class ModuloPageTemplate extends StatelessWidget {
  final String route;
  final StatusBuild statusBuild;
  final void Function()? onPressedAtualiza;
  final void Function()? onPressedNovoItem;
  final String? labelNovoItem;
  final Function(String)? onChangePesquisa;
  final void Function()? onEditCompletPesquisa;
  final List? listaItems;
  final Widget Function(BuildContext, int)? itemBuilderLista;
  final String? initialValueCampoPesquisa;
  final bool isModule;
  final Widget? child;

  const ModuloPageTemplate({
    super.key,
    required this.route,
    required this.statusBuild,
    this.onPressedAtualiza,
    this.onPressedNovoItem,
    this.labelNovoItem,
    this.itemBuilderLista,
    this.listaItems,
    this.onChangePesquisa,
    this.onEditCompletPesquisa,
    this.initialValueCampoPesquisa,
    this.isModule = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ratio = width * 0.005;
    print(ratio);
    return Scaffold(
      drawer: width <= 1000 && isModule ? SideMenu(atual: route) : null,
      appBar:
          width <= 1000 ? AppBar(title: Text(route.replaceAll('/', ''))) : null,
      body: SafeArea(
        child: statusBuild == StatusBuild.loading
            ? const LoadingAtom()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                      visible: width > 1000, child: SideMenu(atual: route)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * ratio, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: AppTheme.defaultPadding),
                          width > 1000
                              ? Text(
                                  route.replaceAll('/', ''),
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: onPressedAtualiza,
                                  child: const Text('Atualiza')),
                              labelNovoItem != null
                                  ? ElevatedButton.icon(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppTheme.defaultPadding * 1.5,
                                          vertical: AppTheme.defaultPadding /
                                              (Responsive.isMobile(context)
                                                  ? 2
                                                  : 1),
                                        ),
                                      ),
                                      onPressed: onPressedNovoItem,
                                      icon: const Icon(Icons.add),
                                      label: Text(labelNovoItem!),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: AppTheme.defaultPadding),
                          onChangePesquisa != null ||
                                  onEditCompletPesquisa != null
                              ? CampoPadraoAtom(
                                  onChange: onChangePesquisa,
                                  onEditComplet: onEditCompletPesquisa,
                                  initialValue: initialValueCampoPesquisa,
                                )
                              : const SizedBox(),
                          const SizedBox(height: AppTheme.defaultPadding / 2),
                          child ??
                              Expanded(
                                child: ListView.builder(
                                  itemCount: listaItems!.length,
                                  itemBuilder: itemBuilderLista!,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
