import 'package:coffee_cup/coffe_cup.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/criar_banner_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:flutter/material.dart';

class CriarBannerPage extends StatefulWidget {
  static const route = '/CriarBanner';
  const CriarBannerPage({Key? key}) : super(key: key);
  @override
  State<CriarBannerPage> createState() => _CriarBannerPageState();
}

class _CriarBannerPageState extends State<CriarBannerPage> {
  final ct = di.get<CriarBannerController>();

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
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        if (ct.banner == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: CoffeeText(
              text: ct.banner?.id == null ? 'Criar Banner' : 'Alterar Banner',
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.defaultPadding),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.defaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CampoPadraoAtom(
                          hintText: 'Link da image',
                          initialValue: ct.banner!.image,
                          onChange: (v) {
                            ct.banner = ct.banner!.copyWith(image: v);
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Link do redirecionamento',
                          initialValue: ct.banner!.link,
                          onChange: (v) {
                            ct.banner = ct.banner!.copyWith(link: v);
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        ButtonPadraoAtom(
                          title: ct.banner?.id == null
                              ? 'Criar Banner'
                              : 'Alterar Banner',
                          icone: Icons.create,
                          onPress: () => ct.criarBanner(context),
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
