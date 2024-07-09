import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_category.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_rarity.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/cria_edita_emblema_controller.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_page.dart';

class CriaEditaEmblemaPage extends StatefulWidget {
  static const route = '/CriaEditaEmblema';
  const CriaEditaEmblemaPage({super.key});
  @override
  State<CriaEditaEmblemaPage> createState() => _CriaEditaEmblemaPageState();
}

class _CriaEditaEmblemaPageState
    extends ManagerPage<CriaEditaEmblemaController, CriaEditaEmblemaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      appBar: const Text('Criar Emblema'),
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
                  hintText: 'Nome do emblema',
                  initialValue: ct.dto.name,
                  onChange: (v) => ct.dto.name = v,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  hintText: 'Descrição do emblema',
                  initialValue: ct.dto.description,
                  numberLines: 3,
                  onChange: (v) => ct.dto.description = v,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  children: [
                    Text(
                      'Beneficios',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          ),
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
                        children: ct.dto.benefits
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: CampoPadraoAtom(
                                  onChange: (v) => e = v,
                                  initialValue: e,
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
                              ct.dto.benefits.add('');
                              ct.state = StateManager.done;
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              ct.dto.benefits.removeLast();
                              ct.state = StateManager.done;
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  children: [
                    Text(
                      'Categoria',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: ct.dto.category,
                  items: AchievementCategory.values
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    ct.dto.category = v!;
                    ct.state = StateManager.done;
                  },
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Disponivel para resgatar',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  value: ct.dto.reclaim,
                  onChanged: (v) {
                    ct.dto.reclaim = v;
                    ct.state = StateManager.done;
                  },
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  children: [
                    Text(
                      'Raridade',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                DropdownButton<AchievementRarity>(
                  isExpanded: true,
                  value: AchievementRarity.byName(ct.dto.rarity),
                  items: AchievementRarity.values
                      .map(
                        (e) => DropdownMenuItem<AchievementRarity>(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    ct.dto.rarity = v!.name;
                    ct.state = StateManager.done;
                  },
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Adicionar imagem',
                  icone: Icons.image,
                  onPress: () => ct.pickerImage(context),
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                ButtonPadraoAtom(
                  title: 'Salvar',
                  icone: Icons.create,
                  onPress: () => ct.criaAlteraEmblema(context),
                ),
              ],
            ),
          ),
        ],
      ),
      state: ct.state,
    );
  }
}
