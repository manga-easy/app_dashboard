import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/error_default_page.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.onMessage(listernerMessage);
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        final state = ct.state;
        switch (state) {
          case StatusBuild.initial:
          case StatusBuild.loading:
            return const LoadingAtom();
          case StatusBuild.erro:
            return const ErrorDefaultPage();
          case StatusBuild.done:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Editar Nível'),
                actions: [
                  IconButton(
                    onPressed: () => ct.deletarNivel(context),
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                ],
              ),
              body: Container(
                margin: const EdgeInsets.all(AppTheme.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultPadding),
                  children: [
                    // String temporada;
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      initialValue: ct.nivelUser!.quantity.toString(),
                      hintText: 'Quantidade de xp do nível atual',
                      onChange: (x) => ct.nivelUser = ct.nivelUser!
                          .copyWith(quantity: int.tryParse(x) ?? 0),
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      initialValue: ct.nivelUser!.lvl.toString(),
                      hintText: 'Nível atual',
                      onChange: (x) => ct.nivelUser =
                          ct.nivelUser!.copyWith(lvl: int.tryParse(x) ?? 0),
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    CampoPadraoAtom(
                      initialValue: ct.nivelUser!.total.toString(),
                      hintText: 'Total xp',
                      onChange: (x) => ct.nivelUser =
                          ct.nivelUser!.copyWith(total: int.tryParse(x) ?? 0),
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
        }
      },
    );
  }
}
