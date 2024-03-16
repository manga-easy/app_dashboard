import 'dart:async';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/send_notification_page.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  static const route = '/Notificacao';
  const NotificacaoPage({Key? key}) : super(key: key);
  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final ct = di.get<NotificacaoController>();

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
    return ModuloPageTemplate(
      route: NotificacaoPage.route,
      statusBuild: ct.state,
      onPressedAtualiza: ct.carregaNotificacao,
      onPressedNovoItem: () => Navigator.pushNamed(
        context,
        SendNotificationPage.route,
      ),
      labelNovoItem: 'Enviar notificação',
      itemBuilderLista: (context, index) {
        final notification = ct.lista[index];
        return Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(notification.titulo)),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final ret = await AppHelps.confirmaDialog(
                        title: 'Tem certeza?',
                        context: context,
                      );
                      if (ret) {
                        unawaited(ct.deleteNotification(notification.id!));
                      }
                    },
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      notification.menssege,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Helps.formetDateFromTimestap(notification.createAt)),
                      ElevatedButton(
                        onPressed: () {
                          AppHelps.confirmaDialog(
                            title: 'Tem certeza?',
                            context: context,
                          ).then((value) {
                            if (value) {
                              ct.reSendNotification(notification).then((value) {
                                if (value) {
                                  AppHelps.confirmaDialog(
                                    title: 'Sucesso',
                                    content: 'Mensagem enviada com sucesso',
                                    context: context,
                                  );
                                }
                              });
                            }
                          });
                        },
                        child: const Text('Re-enviar'),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(color: Colors.white)
          ],
        );
      },
      listaItems: ct.lista,
    );
  }
}
