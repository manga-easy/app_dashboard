import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class HostPage extends StatefulWidget {
  static const route = '/hosts';
  const HostPage({super.key});
  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends ManagerPage<HostController, HostPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: HostPage.route,
      error: ct.error,
      state: ct.state,
      onChangePesquisa: (v) => ct.searchHost = v,
      labelNovoItem: 'Host',
      itemBuilderLista: (context, index) {
        final HostEntity host = ct.list[index];
        if (ct.searchHost.isNotEmpty &&
            ![
              host.hostId.toString(),
              host.name.toLowerCase(),
            ].any((field) => field.contains(ct.searchHost))) {
          return const SizedBox.shrink();
        }
        return InkWell(
          onTap: () => context.push('${HostPage.route}/${host.id}'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, right: 16),
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${host.name} (${host.hostId}) - Order: ${host.order}',
                        ),
                        Text(
                          host.urlApi.length > 30
                              ? '${host.urlApi.substring(0, 30)} ...'
                              : host.urlApi,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result = await AppHelps.confirmaDialog(
                        title: 'Tem certeza ?',
                        context: context,
                      );
                      if (result) {
                        ct.changStatus(host);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: host.status == HostStatus.enable
                          ? Colors.green
                          : Colors.red,
                    ),
                    child: Text(
                      host.status.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      onPressedAtualiza: ct.loadingHost,
      listaItems: ct.list,
      onPressedNovoItem: () => context.push('${HostPage.route}/create'),
    );
  }
}
