import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
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
      drawer: const SideMenu(atual: CriarRecomendacaoPage.route),
      appBar: AppBar(
        title: const Text('Criar Recomendação'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.defaultPadding),
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
                    const SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadraoAtom(
                      hintText: 'Link',
                      controller: ct.link,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding * 2),
                    CampoPadraoAtom(
                      numberLines: 5,
                      hintText: 'Descrição da recomendação',
                      controller: ct.descricaoRecomendacao,
                    ),
                    const SizedBox(height: AppTheme.defaultPadding * 2),
                    const SizedBox(height: AppTheme.defaultPadding * 2),
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
