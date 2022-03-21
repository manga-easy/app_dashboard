import 'package:dashboard_manga_easy/config/app_theme.dart';
import 'package:dashboard_manga_easy/controllers/recuperacao_controller.dart';
import 'package:dashboard_manga_easy/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/widgets/campo_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecuperacaoScreen extends GetView {
  final ct = Get.put(RecuperacaoController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding * 2),
      child: Column(
        children: [
          SizedBox(height: AppTheme.defaultPadding * 2),
          CampoPadrao(
            hintText: 'Antigo User',
            controller: ct.userAntigo,
          ),
          SizedBox(height: AppTheme.defaultPadding),
          CampoPadrao(
            hintText: 'Novo User',
            controller: ct.userNovo,
          ),
          SizedBox(height: AppTheme.defaultPadding * 2),
          ButtonPadrao(
            title: 'consultar',
            icone: Icons.task,
            onPress: () => ct.recuperaDados(),
          )
        ],
      ),
    );
  }
}
