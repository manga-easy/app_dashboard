import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/update_notes/domain/update_notes_entity.dart';
import 'package:dashboard_manga_easy/modules/update_notes/presenter/controllers/update_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/export_manager.dart';

class ReleaseNotesPage extends StatefulWidget {
  static const route = '/update-notes';
  const ReleaseNotesPage({super.key});

  @override
  State<ReleaseNotesPage> createState() => _ReleaseNotesPageState();
}

class _ReleaseNotesPageState
    extends ManagerPage<UpdateNotesController, ReleaseNotesPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: ReleaseNotesPage.route,
      state: ct.state,
      error: ct.error,
      listaItems: ct.listAllVersions,
      onPressedAtualiza: ct.listAllVersion,
      onPressedNovoItem: () => context.push('${ReleaseNotesPage.route}/create'),
      labelNovoItem: 'Nova nota de atualização',
      itemBuilderLista: (context, index) {
        final UpdateNotesEntity updates = ct.listAllVersions[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(updates.version),
                subtitle: Text(
                  updates.description.isNotEmpty
                      ? updates.features[0].description
                      : '',
                ),
                onTap: () =>
                    context.push('${ReleaseNotesPage.route}/${updates.id}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
