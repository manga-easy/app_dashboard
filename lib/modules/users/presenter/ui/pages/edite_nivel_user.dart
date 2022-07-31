import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/edite_nivel_user_controller.dart';
import 'package:flutter/material.dart';

class EditeNivelUserPage extends StatefulWidget {
  static const route = '/EditeNivelUser';
  const EditeNivelUserPage({Key? key}) : super(key: key);
  @override
  State<EditeNivelUserPage> createState() => _EditeNivelUserPageState();
}

class _EditeNivelUserPageState extends State<EditeNivelUserPage> {
  final ct = di.get<EditeNivelUserController>();

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
        if (ct.nivelUser == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Editar Nível'),
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
                // String temporada;
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  initialValue: ct.nivelUser!.quantity.toString(),
                  hintText: 'Quantidade de xp do nível atual',
                  onChange: (x) => ct.nivelUser!.quantity = int.tryParse(x) ?? 0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  initialValue: ct.nivelUser!.lvl.toString(),
                  hintText: 'Nível atual',
                  onChange: (x) => ct.nivelUser!.lvl = int.tryParse(x) ?? 0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  initialValue: ct.nivelUser!.total.toString(),
                  hintText: 'Total xp',
                  onChange: (x) => ct.nivelUser!.total = int.tryParse(x) ?? 0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar',
                  icone: Icons.create,
                  onPress: () => ct.salvarNivel(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
