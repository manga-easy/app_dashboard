import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/organisms/form_notificacao.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/manager_page.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});
  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState
    extends ManagerPage<SendNotificationController, SendNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      appBar: const Text('Enviar Notificações'),
      error: ct.error,
      state: ct.state,
      pageDone: () {
        return Column(
          children: [
            FormNotificacao(controller: ct),
            const SizedBox(height: AppTheme.defaultPadding),
            OutlinedButton(
              onPressed: () async {
                final user = await AppHelps.bottomSheet(
                  context: context,
                  child: SelectUser(future: ct.pesquisaUser),
                );
                if (user is User) {
                  setState(() {
                    ct.test = user;
                  });
                }
              },
              child: Text(ct.test == null ? 'Escolha um user' : ct.test!.name),
            ),
            const SizedBox(height: AppTheme.defaultPadding),
            ButtonPadraoAtom(
              onPress: () => ct.enviaNotificacaoTest(context),
              icone: Icons.send,
              title: 'Enviar Notificação de teste',
            ),
          ],
        );
      },
    );
  }
}
