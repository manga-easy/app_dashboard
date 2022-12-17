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
      statusBuild: ct.status,
      labelNovoItem: 'Host',
      itemBuilderLista: (context, index) {
        HostModel host = ct.list[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                HostDetailsPage.route,
                arguments: host,
              ),
              leading: Text(host.name),
              title: Text(host.name),
              subtitle: Text(
                host.status,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: () => ct.deleteHost(context, host),
                icon: const Icon(Icons.delete),
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
