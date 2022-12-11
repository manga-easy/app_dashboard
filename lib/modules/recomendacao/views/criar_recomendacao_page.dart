import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ct,
      builder: (context, value, child) {
        if (ct.recomendacao == null) return const LoadingAtom();
        return Scaffold(
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
                    ),
                    child: Column(
                      children: [
                        CampoPadraoAtom(
                          hintText: 'Nome do manga',
                          initialValue: ct.recomendacao!.title,
                          onChange: (v) {
                            ct.recomendacao!.title = v;
                            ct.recomendacao!.uniqueid =
                                Helps.convertUniqueid(v);
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Link',
                          initialValue: ct.recomendacao!.link,
                          onChange: (v) => ct.recomendacao!.link = v,
                        ),
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
      },
    );
  }
}
