import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/banners_controller.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/criar_banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class BannerPage extends StatefulWidget {
  static const route = '/Banner';
  const BannerPage({Key? key}) : super(key: key);
  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final ct = di.get<BannerController>();

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
      valueListenable: ct.state,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: BannerPage.route,
          statusBuild: ct.state.value,
          labelNovoItem: 'Nova Banner',
          onPressedAtualiza: ct.listaBanner,
          itemBuilderLista: (context, index) {
            BannerModel reco = ct.listaBannerItens[index];
            return Card(
              child: Column(
                children: [
                  ListTile(
                    textColor: Colors.white,
                    title: Text(
                      reco.link,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.network(
                      reco.image,
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
                              CriarBannerPage.route,
                              arguments: reco,
                            )
                            .then((value) => ct.listaBanner()),
                      ),
                      ButtonPadraoAtom(
                        title: 'Deletar',
                        icone: Icons.delete_forever,
                        onPress: () => ct
                            .deleteBanner(reco, context)
                            .then((value) => ct.listaBanner()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            );
          },
          listaItems: ct.listaBannerItens,
          onPressedNovoItem: () => Navigator.of(context)
              .pushNamed(CriarBannerPage.route)
              .then((value) => ct.listaBanner()),
        );
      },
    );
  }
}
