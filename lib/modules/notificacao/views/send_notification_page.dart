import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/organisms/form_notificacao.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/organisms/select_user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';

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
    ct.onMessage(listernerMessage);
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null && mounted) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
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
                child:
                    Text(ct.test == null ? 'Escolha um user' : ct.test!.name),
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              ButtonPadraoAtom(
                onPress: () => ct.enviaNotificacaoTest(context),
                icone: Icons.send,
                title: 'Enviar Notificação de teste',
              )
            ],
          ),
        );
      },
    );
  }
}
