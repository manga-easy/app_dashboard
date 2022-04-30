import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/recupercao/controllers/recuperacao_controller.dart';
import 'package:flutter/material.dart';

class RecuperacaoPage extends StatefulWidget {
  static const route = '/Recuperacao';
  const RecuperacaoPage({Key? key}) : super(key: key);
  @override
  State<RecuperacaoPage> createState() => _RecuperacaoPageState();
}

class _RecuperacaoPageState extends State<RecuperacaoPage> {
  final ct = di.get<RecuperacaoController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding * 2),
      child: Column(
        children: [
          SizedBox(height: AppTheme.defaultPadding * 2),
          CampoPadraoAtom(
            hintText: 'Antigo User',
            controller: ct.userAntigo,
          ),
          SizedBox(height: AppTheme.defaultPadding),
          CampoPadraoAtom(
            hintText: 'Novo User',
            controller: ct.userNovo,
          ),
          SizedBox(height: AppTheme.defaultPadding * 2),
          ButtonPadraoAtom(
            title: 'consultar',
            icone: Icons.task,
            onPress: () => ct.recuperaDados(context),
          )
        ],
      ),
    );
  }
}
