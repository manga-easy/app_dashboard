import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:flutter/material.dart';

class CriarRecomendacaoPage extends StatefulWidget {
  static const route = '/CriarRecomendacao';
  const CriarRecomendacaoPage({Key? key}) : super(key: key);
  @override
  State<CriarRecomendacaoPage> createState() => _CriarRecomendacaoPageState();
}

class _CriarRecomendacaoPageState extends State<CriarRecomendacaoPage> {
  final ct = di.get<CriarRecomendacaoController>();

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
                    CampoPadraoAtom(
                      hintText: 'Nome do manga',
                      controller: ct.nomeManga,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadraoAtom(
                      hintText: 'Link',
                      controller: ct.link,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadraoAtom(
                      numberLines: 5,
                      hintText: 'Descrição da recomendação',
                      controller: ct.descricaoRecomendacao,
                    ),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    SizedBox(height: AppTheme.defaultPadding * 2),
                    ButtonPadraoAtom(
                      title: 'Criar recomendação',
                      icone: Icons.create,
                      onPress: () => ct.criarRecomendacao(context),
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
