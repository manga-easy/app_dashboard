import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/criar_banner_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

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
      valueListenable: ct,
      builder: (context, value, child) {
        if (ct.banner == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Banner'),
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
                          hintText: 'Link da image',
                          initialValue: ct.banner!.image,
                          onChange: (v) {
                            ct.banner!.image = v;
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        CampoPadraoAtom(
                          hintText: 'Link do redirecionamento',
                          initialValue: ct.banner!.link,
                          onChange: (v) => ct.banner!.link = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        ButtonPadraoAtom(
                          title: 'Criar Banner',
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
