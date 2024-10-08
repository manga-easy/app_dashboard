import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/controllers/criar_banner_controller.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/events/details_banner_event.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/pages/banners_page.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class CriarBannerPage extends StatefulWidget {
  const CriarBannerPage({super.key});
  @override
  State<CriarBannerPage> createState() => _CriarBannerPageState();
}

class _CriarBannerPageState
    extends ManagerPage<CriarBannerController, CriarBannerPage> {
  @override
  void initState() {
    ct.onNavigation(
      (e) => switch (e) {
        DetailsBannerEventSuccess() => showSuccess(e),
      },
    );
    super.initState();
  }

  void showSuccess(DetailsBannerEventSuccess event) {
    context.pushReplacement(BannerPage.route);
    AppHelps.confirmaDialog(
      title: 'Sucesso',
      content: 'Banner ${event.operation} com sucesso',
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      error: ct.error,
      appBar: Text(
        ct.id == null ? 'Criar Banner' : 'Alterar Banner',
      ),
      pageDone: () => Padding(
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
                    initialValue: ct.dto.image,
                    onChange: (v) {
                      ct.dto.image = v;
                    },
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  CampoPadraoAtom(
                    hintText: 'Link do redirecionamento',
                    initialValue: ct.dto.link,
                    onChange: (v) {
                      ct.dto.link = v;
                    },
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  ButtonPadraoAtom(
                    title: 'Adicionar imagem',
                    icone: Icons.image,
                    onPress: () => ct.pickerImage(context),
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  ButtonPadraoAtom(
                    title: ct.id == null ? 'Criar Banner' : 'Alterar Banner',
                    icone: Icons.create,
                    onPress: ct.criarBanner,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      state: ct.state,
    );
  }
}
