import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/organisms/form_notificacao.dart';
import 'package:dashboard_manga_easy/modules/permissoes/presenter/ui/organisms/select_user.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class SendNotificationPage extends StatefulWidget {
  static const route = '/SendNotification';
  const SendNotificationPage({Key? key}) : super(key: key);
  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final ct = di.get<SendNotificationController>();

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
      valueListenable: ct,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Enviar Notificações'),
          ),
          body: Column(
            children: [
              FormNotificacao(controller: ct),
              const SizedBox(height: AppTheme.defaultPadding),
              OutlinedButton(
                onPressed: () async {
                  var user = await AppHelps.bottomSheet(
                    context: context,
                    child: SelectUser(future: ct.pesquisaUser),
                  );
                  if (user is User) {
                    setState(() {
                      ct.test = user;
                    });
                  }
                },
                child:
                    Text(ct.test == null ? 'Escolha um user' : ct.test!.name),
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              ButtonPadraoAtom(
                onPress: () => ct.enviaNotificacaoTest(context),
                icone: Icons.send,
                title: "Enviar Notificação de teste",
              )
            ],
          ),
        );
      },
    );
  }
}
