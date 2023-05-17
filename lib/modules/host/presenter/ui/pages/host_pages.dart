import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/controllers/host_controller.dart';
import 'package:dashboard_manga_easy/modules/host/presenter/ui/pages/host_details_page.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class HostPage extends StatefulWidget {
  static const route = '/Host';
  const HostPage({super.key});
  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final HostController ct = di();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() => setState(() => {}));
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
      route: HostPage.route,
      statusBuild: ct.state,
      labelNovoItem: 'Host',
      itemBuilderLista: (context, index) {
        HostModel host = ct.list[index];
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            HostDetailsPage.route,
            arguments: host,
          ),
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
                        Text(host.name),
                        Text(
                          host.host.length > 30
                              ? '${host.host.substring(0, 30)} ...'
                              : host.host,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => ct.deleteHost(context, host),
                        child: const Icon(Icons.close),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => ct.changStatus(host),
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
                  )
                ],
              ),
            ),
          ),
        );
      },
      onPressedAtualiza: ct.loadingHost,
      listaItems: ct.list,
      onPressedNovoItem: () => Navigator.pushNamed(
        context,
        HostDetailsPage.route,
      ),
    );
  }
}
