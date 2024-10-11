import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/update_notes/data/dtos/update_notes_dto.dart';
import 'package:dashboard_manga_easy/modules/update_notes/presenter/controllers/update_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/export_manager.dart';

class CreateUpdateNotesPage extends StatefulWidget {
  const CreateUpdateNotesPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateUpdateNotesPageState();
}

class _CreateUpdateNotesPageState
    extends ManagerPage<UpdateNotesController, CreateUpdateNotesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      state: ct.state,
      error: ct.error,
      pageDone: () => ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                CampoPadraoAtom(
                  hintText: 'Número da versão',
                  initialValue: ct.releaseNotesDto.version,
                  onChange: (v) => ct.releaseNotesDto.version = v,
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                CampoPadraoAtom(
                  hintText: 'Descrição',
                  initialValue: ct.releaseNotesDto.description,
                  onChange: (v) => ct.releaseNotesDto.description = v,
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                Row(
                  children: [
                    Text(
                      'Correções',
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultPadding * 2,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: AppTheme.defaultPadding / 2),
                      Column(
                        children: ct.releaseNotesDto.fixes
                            .map(
                              (fix) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CampoPadraoAtom(
                                      hintText: 'Título da correção',
                                      onChange: (v) => fix.title = v,
                                      initialValue: fix.title,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                    CampoPadraoAtom(
                                      hintText: 'Subtítulo da correção',
                                      onChange: (v) => fix.subtitle = v,
                                      initialValue: fix.subtitle,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                    CampoPadraoAtom(
                                      hintText: 'Descrição da correção',
                                      onChange: (v) => fix.description = v,
                                      initialValue: fix.description,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              ct.releaseNotesDto.fixes.add(FixDto.empty());
                              ct.state = StateManager.done;
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              if (ct.releaseNotesDto.fixes.isNotEmpty) {
                                ct.releaseNotesDto.fixes.removeLast();
                                ct.state = StateManager.done;
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                Row(
                  children: [
                    Text(
                      'Melhorias',
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.defaultPadding * 2,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: AppTheme.defaultPadding / 2),
                      Column(
                        children: ct.releaseNotesDto.features
                            .map(
                              (feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CampoPadraoAtom(
                                      hintText: 'Título da melhoria',
                                      onChange: (v) => feature.title = v,
                                      initialValue: feature.title,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                    CampoPadraoAtom(
                                      hintText: 'Subtítulo da melhoria',
                                      onChange: (v) => feature.subtitle = v,
                                      initialValue: feature.subtitle,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                    CampoPadraoAtom(
                                      hintText: 'Descrição da melhoria',
                                      onChange: (v) => feature.description = v,
                                      initialValue: feature.description,
                                    ),
                                    const SizedBox(
                                      height: AppTheme.defaultPadding / 2,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              ct.releaseNotesDto.features
                                  .add(FeatureDto.empty());
                              ct.state = StateManager.done;
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              if (ct.releaseNotesDto.features.isNotEmpty) {
                                ct.releaseNotesDto.features.removeLast();
                                ct.state = StateManager.done;
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      ButtonPadraoAtom(
                        title: 'Salvar',
                        icone: Icons.create,
                        onPress: () {
                          ct.releasesId == 'create'
                              ? ct.createRelease(context)
                              : ct.updateRelease(context);
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      ButtonPadraoAtom(
                        title: 'Deletar',
                        icone: Icons.create,
                        onPress: () async {
                          await ct.deleteRelease(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: Text(ct.releasesId == null ? 'Criar nota' : 'Atualizar nota'),
    );
  }
}
