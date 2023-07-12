import 'package:coffee_cup/coffe_cup.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditPermissoesPage extends StatefulWidget {
  static const route = '/permissions/edit';
  const EditPermissoesPage({super.key});
  @override
  State<EditPermissoesPage> createState() => _EditPermissoesPageState();
}

class _EditPermissoesPageState extends State<EditPermissoesPage> {
  final ct = di.get<EditPermissoesController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.onMessage(listernerMessage);
    ct.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null && mounted) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      state: ct.state,
      done: Scaffold(
        appBar: AppBar(
          title: const CoffeeText(text: 'Criar Permissões'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.defaultPadding,
          ),
          children: [
            DropdownButton<int>(
              isExpanded: true,
              value: ct.permissoes?.value,
              items: LevelPermissoes.values
                  .map((e) => DropdownMenuItem<int>(
                        value: e.value,
                        child: CoffeeText(text: e.name),
                      ))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  ct.permissoes = ct.permissoes!.copyWith(value: v);
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
                    ct.permissoes = ct.permissoes!.copyWith(userId: user.id!);
                  });
                }
              },
              child: NameUserBuild(
                future: ct.getNameUser(userId: ct.permissoes?.userId ?? ''),
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
      ),
    );
  }
}
