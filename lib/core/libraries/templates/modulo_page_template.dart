import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/core/libraries/widgets/error_pages/error_default_page.dart';
import 'package:dashboard_manga_easy/core/libraries/widgets/error_pages/logged_out_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_page_builder.dart';

class ModuloPageTemplate extends StatelessWidget {
  final String route;
  final StateManager state;
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
  final Object? error;

  const ModuloPageTemplate({
    super.key,
    required this.route,
    required this.state,
    required this.error,
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
    return ManagerPageBuilder(
      state: state,
      pageInitial: () => const Center(
        child: CircularProgressIndicator(),
      ),
      pageError: (error) => const ErrorDefaultPage(),
      pageDisconnected: () => const ErrorDefaultPage(),
      pageLoading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      pageLoggedOut: () => const LoggedOutPage(),
      pageMaintenance: () => const ErrorDefaultPage(),
      error: error,
      drawer: width <= 1000 && isModule ? SideMenu(atual: route) : null,
      appBar:
          width <= 1000 ? AppBar(title: Text(route.replaceAll('/', ''))) : null,
      pageDone: () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: width > 1000,
            child: SideMenu(atual: route),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * ratio,
                vertical: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppTheme.defaultPadding),
                  if (width > 1000)
                    Text(
                      route.replaceAll('/', ''),
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  else
                    const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: onPressedAtualiza,
                        child: const Text('Atualiza'),
                      ),
                      if (labelNovoItem != null)
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.defaultPadding * 1.5,
                              vertical: AppTheme.defaultPadding /
                                  (Responsive.isMobile(context) ? 2 : 1),
                            ),
                          ),
                          onPressed: onPressedNovoItem,
                          icon: const Icon(Icons.add),
                          label: Text(labelNovoItem!),
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: AppTheme.defaultPadding),
                  if (onChangePesquisa != null || onEditCompletPesquisa != null)
                    CampoPadraoAtom(
                      onChange: onChangePesquisa,
                      onEditComplet: onEditCompletPesquisa,
                      initialValue: initialValueCampoPesquisa,
                    )
                  else
                    const SizedBox(),
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
    );
  }
}
