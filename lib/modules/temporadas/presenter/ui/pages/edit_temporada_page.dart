import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/temporadas/presenter/controllers/edit_temporada_controller.dart';
import 'package:flutter/material.dart';

class EditTemporadasPage extends StatefulWidget {
  static const route = '/EditTemporadas';
  const EditTemporadasPage({super.key});
  @override
  State<EditTemporadasPage> createState() => _EditTemporadasPageState();
}

class _EditTemporadasPageState extends State<EditTemporadasPage> {
  final ct = di.get<EditTemporadasController>();

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
        if (ct.temporada == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Temporada'),
          ),
          body: Container(
            margin: const EdgeInsets.all(AppTheme.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
              children: [
                CampoPadraoAtom(
                  hintText: 'Titulo da temporada',
                  initialValue: ct.temporada!.nome,
                  onChange: (x) => ct.temporada!.nome = x,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar Temporada',
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
