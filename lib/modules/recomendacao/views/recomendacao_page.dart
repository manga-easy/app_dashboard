import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecomendacaoPage extends StatefulWidget {
  static const route = '/Recomendacao';
  const RecomendacaoPage({Key? key}) : super(key: key);
  @override
  State<RecomendacaoPage> createState() => _RecomendacaoPageState();
}

class _RecomendacaoPageState extends State<RecomendacaoPage> {
  final ct = di.get<RecomendacaoController>();

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
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: RecomendacaoPage.route,
          statusBuild: ct.status.value,
          labelNovoItem: 'Nova recomendação',
          onPressedAtualiza: ct.listaRecomendacao,
          itemBuilderLista: (context, index) {
            RecomendacoesModel reco = ct.listaRecomendacaoItens[index];
            return Card(
              child: Column(
                children: [
                  ListTile(
                    textColor: Colors.white,
                    title: Text(
                      reco.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.network(
                      reco.link,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonPadraoAtom(
                        title: "Editar",
                        icone: Icons.edit,
                        onPress: () => Navigator.of(context)
                            .pushNamed(
                              CriarRecomendacaoPage.route,
                              arguments: reco,
                            )
                            .then((value) => ct.listaRecomendacao()),
                      ),
                      ButtonPadraoAtom(
                        title: "Deletar",
                        icone: Icons.delete_forever,
                        onPress: () =>
                            ct.deleteRecomendacao(reco, context).then((value) => ct.listaRecomendacao()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            );
          },
          listaItems: ct.listaRecomendacaoItens,
          onPressedNovoItem: () => Navigator.of(context)
              .pushNamed(CriarRecomendacaoPage.route)
              .then((value) => ct.listaRecomendacao()),
        );
      },
    );
  }
}
