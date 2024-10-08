import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:page_manager/manager_page.dart';

class RecomendacaoPage extends StatefulWidget {
  static const route = '/recommendations';
  const RecomendacaoPage({super.key});
  @override
  State<RecomendacaoPage> createState() => _RecomendacaoPageState();
}

class _RecomendacaoPageState
    extends ManagerPage<RecomendacaoController, RecomendacaoPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      onChangePesquisa: ct.search,
      route: RecomendacaoPage.route,
      error: ct.error,
      state: ct.state,
      labelNovoItem: 'Nova recomendação',
      onPressedAtualiza: ct.listaRecomendacao,
      itemBuilderLista: (context, index) {
        final RecommendationsEntity reco = ct.listaRecomendacaoItens[index];
        if (!reco.title.toLowerCase().contains(ct.seach.toLowerCase()) &&
            ct.seach.isNotEmpty) {
          return const SizedBox.shrink();
        }
        return Card(
          child: Column(
            children: [
              ListTile(
                onTap: () => Helps.copyText(reco.title, context),
                title: Text(
                  reco.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  'Artista: ${reco.artistName ?? 'N/A'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.fromMillisecondsSinceEpoch(reco.createdAt),
                  ),
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
                    title: 'Editar',
                    icone: Icons.edit,
                    onPress: () => context
                        .push('${RecomendacaoPage.route}/${reco.id}')
                        .then((value) => ct.listaRecomendacao()),
                  ),
                  ButtonPadraoAtom(
                    title: 'Deletar',
                    icone: Icons.delete_forever,
                    onPress: () => ct
                        .deleteRecomendacao(reco, context)
                        .then((value) => ct.listaRecomendacao()),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      listaItems: ct.listaRecomendacaoItens,
      onPressedNovoItem: () => context
          .push('${RecomendacaoPage.route}/create')
          .then((value) => ct.listaRecomendacao()),
    );
  }
}
