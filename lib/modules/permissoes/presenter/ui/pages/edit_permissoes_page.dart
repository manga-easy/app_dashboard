import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/organisms/select_user.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

enum LevelPermissoes {
  none(value: 0),
  admin(value: 90),
  parceiro(value: 40),
  autor(value: 30),
  root(value: 100);

  final int value;
  const LevelPermissoes({required this.value});
}

class EditPermissoesPage extends StatefulWidget {
  static const route = '/EditPermissoes';
  const EditPermissoesPage({super.key});
  @override
  State<EditPermissoesPage> createState() => _EditPermissoesPageState();
}

class _EditPermissoesPageState extends State<EditPermissoesPage> {
  final ct = di.get<EditPermissoesController>();

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
      valueListenable: ct,
      builder: (context, value, child) {
        if (ct.permissoes == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Permissões'),
          ),
          body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
            children: [
              DropdownButton<int>(
                isExpanded: true,
                value: ct.permissoes!.value,
                items: LevelPermissoes.values
                    .map((e) => DropdownMenuItem<int>(
                          value: e.value,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (v) {
                  ct.permissoes!.value = v!;
                  ct.notifyListeners();
                },
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              OutlinedButton(
                onPressed: () async {
                  var user = await AppHelps.bottomSheet(
                    context: context,
                    child: SelectUser(future: ct.pesquisaUser),
                  );
                  if (user is User) {
                    setState(() {
                      ct.permissoes!.userId = user.id!;
                    });
                  }
                },
                child: NameUserBuild(
                  future: ct.getNameUser(userId: ct.permissoes!.userId),
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
      },
    );
  }
}
