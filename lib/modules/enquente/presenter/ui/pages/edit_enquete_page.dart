import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/organisms/select_user.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EditEnquetePage extends StatefulWidget {
  static const route = '/EditEnquete';
  const EditEnquetePage({super.key});
  @override
  State<EditEnquetePage> createState() => _EditEnquetePageState();
}

class _EditEnquetePageState extends State<EditEnquetePage> {
  final ct = di.get<EditEnqueteController>();

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
            title: const Text('Criar Enquete'),
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
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar',
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
