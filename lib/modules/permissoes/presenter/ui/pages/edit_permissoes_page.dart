import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/controllers/edit_permissoes_controller.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

enum LevelPermissoes {
  none(value: 0),
  admin(value: 90),
  parceiro(value: 40),
  autor(value: 30);

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
      valueListenable: ct,
      builder: (context, value, child) {
        if (ct.permissoes == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Permissões'),
          ),
          body: Container(
            margin: const EdgeInsets.all(AppTheme.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.secondaryColor,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
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
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                  onChanged: print,
                  selectedItem: "Brazil",
                ),
                OutlinedButton(
                  onPressed: () => null,
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
          ),
        );
      },
    );
  }
}
