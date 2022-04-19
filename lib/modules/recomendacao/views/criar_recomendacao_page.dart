import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/criar_recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
                      controller: ct.nomeManga,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadrao(
                      hintText: 'Link',
                      controller: ct.link,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadrao(
                      numberLines: 5,
                      hintText: 'Descrição da recomendação',
                      controller: ct.descricaoRecomendacao,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    DropdownSearch<String>.multiSelection(
                        mode: Mode.MENU,
                        showSearchBox: true,
                        showSelectedItems: true,
                        items: [
                          "Brazil",
                          "Italia",
                          "Tunisia",
                          'Canada',
                        ],
                        dropdownSearchDecoration: InputDecoration(
                            labelText: 'Genêros',
                            hintText: 'Selecione os genêros do manga'),
                        onChanged: (event) => ct.generos = event),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    ButtonPadrao(
                      title: 'Criar recomendação',
                      icone: Icons.create,
                      onPress: () => ct.criarRecomendacao(),
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
