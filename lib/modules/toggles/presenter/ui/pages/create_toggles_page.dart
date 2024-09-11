import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/controllers/create_toggle_controller.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/events/details_banner_event.dart';
import 'package:dashboard_manga_easy/modules/toggles/presenter/ui/pages/toggles_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class CreateTogglesPage extends StatefulWidget {
  const CreateTogglesPage({super.key});
  @override
  State<CreateTogglesPage> createState() => _CreateTogglesPageState();
}

class _CreateTogglesPageState
    extends ManagerPage<CreateToggleController, CreateTogglesPage> {
  @override
  void initState() {
    ct.onNavigation(
      (e) => switch (e) {
        DetailsTogglesEventSuccess() => showSuccess(e),
      },
    );
    super.initState();
  }

  void showSuccess(DetailsTogglesEventSuccess event) {
    context.pushReplacement(TogglesPage.route);
    AppHelps.confirmaDialog(
      title: 'Sucesso',
      content: 'Toggle ${event.operation} com sucesso',
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      error: ct.error,
      appBar: Text(
        ct.toggle?.id == null ? 'Criar Toggle' : 'Alterar Toggle',
      ),
      pageDone: () => Padding(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CampoPadraoAtom(
                    hintText: 'Name',
                    initialValue: ct.dto.name,
                    onChange: (v) {
                      ct.dto.name = v;
                    },
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  CampoPadraoAtom(
                    hintText: 'Descrição',
                    initialValue: ct.dto.description,
                    onChange: (v) {
                      ct.dto.description = v;
                    },
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  CampoPadraoAtom(
                    hintText: 'valor',
                    initialValue: ct.dto.value,
                    onChange: (v) {
                      ct.dto.value = v;
                    },
                  ),
                  const SizedBox(height: AppTheme.defaultPadding * 2),
                  ButtonPadraoAtom(
                    title: ct.toggle?.id == null
                        ? 'Criar Toggle'
                        : 'Alterar Toggle',
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
