import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/criar_recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CriarRecomendacaoPage extends GetView {
  static const router = '/criar.recomendacao';
  final ct = Get.put(CriarRecomendacaoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Recomendação'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.secondaryColor,
                ),
                child: Column(
                  children: [
                    CampoPadrao(
                      hintText: 'Nome do manga',
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadrao(
                      hintText: 'Link',
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadrao(
                      hintText: 'Descrição da recomendação',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
