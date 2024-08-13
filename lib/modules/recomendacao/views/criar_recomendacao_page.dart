import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/atoms/name_user_build.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/criar_recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class CriarRecomendacaoPage extends StatefulWidget {
  const CriarRecomendacaoPage({super.key});
  @override
  State<CriarRecomendacaoPage> createState() => _CriarRecomendacaoPageState();
}

class _CriarRecomendacaoPageState
    extends ManagerPage<CriarRecomendacaoController, CriarRecomendacaoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      state: ct.state,
      error: ct.error,
      appBar: Text(
        ct.recomendacao?.id == null
            ? 'Criar Recomendação'
            : 'Editar Recomendação',
      ),
      pageDone: () => Column(
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
                  initialValue: ct.recomendacao?.title,
                  onChange: (v) {
                    ct.recomendacao = ct.recomendacao?.copyWith(
                      title: v,
                      uniqueid: Helps.convertUniqueid(v),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                ButtonPadraoAtom(
                  title: 'Adicionar imagem',
                  icone: Icons.image,
                  onPress: () => ct.pickerImage(context),
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecioner o artista',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: AppTheme.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onLongPress: () => Helps.copyText(
                              ct.recomendacao?.artistId,
                              context,
                            ),
                            onPressed: () async {
                              final user = await AppHelps.bottomSheet(
                                context: context,
                                child: SelectUser(future: ct.pesquisaUser),
                              );
                              if (user is User) {
                                setState(() {
                                  ct.recomendacao = ct.recomendacao!.copyWith(
                                    artistId: user.id!,
                                    artistName: user.name,
                                  );
                                });
                              }
                            },
                            child: NameUserBuild(
                              future: ct.getNameUser(
                                userId: ct.recomendacao?.artistId ?? '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.defaultPadding * 2),
                ButtonPadraoAtom(
                  title: ct.recomendacao?.id == null
                      ? 'Criar Recomendação'
                      : 'Editar Recomendação',
                  icone: Icons.create,
                  onPress: () => ct.criarRecomendacao(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
