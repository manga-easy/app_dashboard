import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/temporadas_controller.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/ui/pages/edit_temporada_page.dart';
import 'package:flutter/material.dart';

class TemporadasPage extends StatefulWidget {
  static const route = '/Temporadas';
  const TemporadasPage({super.key});
  @override
  State<TemporadasPage> createState() => _TemporadasPageState();
}

class _TemporadasPageState extends State<TemporadasPage> {
  final ct = di.get<TemporadasController>();

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
    return ValueListenableBuilder(
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: TemporadasPage.route,
          statusBuild: ct.status.value,
          onPressedAtualiza: ct.carregaTemporadas,
          labelNovoItem: 'Adicionar permissão',
          onPressedNovoItem: () => Navigator.pushNamed(
            context,
            EditTemporadasPage.route,
          ),
          itemBuilderLista: (context, index) {
            var data = ct.temporadas[index];
            return Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  EditTemporadasPage.route,
                  arguments: data,
                ).then((value) => ct.carregaTemporadas()),
                title: Text(
                  'Titulo: ${data.nome}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  'Ordem: ${data.number}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => ct.removeTemporadas(data.id!, context),
                ),
              ),
            );
          },
          listaItems: ct.temporadas,
        );
      },
    );
  }
}
