import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class EditPermissoesPage extends StatefulWidget {
  const EditPermissoesPage({super.key});
  @override
  State<EditPermissoesPage> createState() => _EditPermissoesPageState();
}

class _EditPermissoesPageState
    extends ManagerPage<EditPermissoesController, EditPermissoesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      state: ct.state,
      error: ct.error,
      appBar: const Text('Criar Permissões'),
      pageDone: () => ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding,
        ),
        children: [
          DropdownButton<int>(
            isExpanded: true,
            value: ct.permission.value,
            items: LevelPermissoes.values
                .map(
                  (e) => DropdownMenuItem<int>(
                    value: e.value,
                    child: Text(e.name),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() {
                ct.permission = ct.permission.copyWith(value: v);
              });
            },
          ),
          const SizedBox(height: AppTheme.defaultPadding),
          OutlinedButton(
            onPressed: () async {
              final user = await AppHelps.bottomSheet(
                context: context,
                child: SelectUser(future: ct.pesquisaUser),
              );
              if (user is User) {
                setState(() {
                  ct.permission = ct.permission.copyWith(userId: user.id!);
                });
              }
            },
            child: NameUserBuild(
              future: ct.getEmail(userId: ct.permission.userId),
            ),
          ),
          const SizedBox(height: AppTheme.defaultPadding),
          ButtonPadraoAtom(
            title: 'Salvar permissão',
            icone: Icons.create,
            onPress: () => ct.salvarEditaDados(context),
          ),
        ],
      ),
    );
  }
}
