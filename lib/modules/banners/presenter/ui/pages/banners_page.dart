import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/banners_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class BannerPage extends StatefulWidget {
  static const route = '/banner';
  const BannerPage({super.key});
  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends ManagerPage<BannerController, BannerPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: BannerPage.route,
      error: ct.error,
      state: ct.state,
      labelNovoItem: 'Novo Banner',
      onPressedAtualiza: ct.listaBanner,
      itemBuilderLista: (context, index) {
        final BannerEntity banner = ct.listaBannerItens[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                textColor: Colors.white,
                title: Text(
                  banner.link,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.network(
                  banner.image,
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
                    onPress: () => context.go('/banner/${banner.id}'),
                  ),
                  ButtonPadraoAtom(
                    title: 'Deletar',
                    icone: Icons.delete_forever,
                    onPress: () => ct
                        .deleteBanner(banner.id, context)
                        .then((value) => ct.listaBanner()),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      listaItems: ct.listaBannerItens,
      onPressedNovoItem: () => context.go('/banner/null'),
    );
  }
}
