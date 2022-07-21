import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/controllers/enquete_controller.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/ui/pages/edit_enquete_page.dart';
import 'package:flutter/material.dart';

class EnquetePage extends StatefulWidget {
  static const route = '/Enquete';
  const EnquetePage({super.key});
  @override
  State<EnquetePage> createState() => _EnquetePageState();
}

class _EnquetePageState extends State<EnquetePage> {
  final ct = di.get<EnqueteController>();

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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: EnquetePage.route,
          statusBuild: ct.status.value,
          onPressedAtualiza: ct.carregaEnquete,
          labelNovoItem: 'Adicionar enquete',
          onPressedNovoItem: () => Navigator.pushNamed(
            context,
            EditEnquetePage.route,
          ),
          itemBuilderLista: (context, index) {
            var data = ct.enquetes[index];
            return Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  EditEnquetePage.route,
                  arguments: data,
                ).then((value) => ct.carregaEnquete()),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => ct.removeEnquete(data.id!, context),
                ),
              ),
            );
          },
          listaItems: ct.enquetes,
        );
      },
    );
  }
}
