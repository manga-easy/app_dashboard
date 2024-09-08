import 'dart:async';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/create_notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/atoms/status_notification.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class NotificacaoPage extends StatefulWidget {
  static const route = '/notifications';
  const NotificacaoPage({super.key});
  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState
    extends ManagerPage<NotificacaoController, NotificacaoPage> {
  @override
  Widget build(BuildContext context) {
    return ModuloPageTemplate(
      route: NotificacaoPage.route,
      state: ct.state,
      error: ct.error,
      onPressedAtualiza: ct.carregaNotificacao,
      onPressedNovoItem: () => context.push('${NotificacaoPage.route}/create'),
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
                  Expanded(
                    child: Row(
                      children: [
                        StatusNotification(status: notification.status),
                        const SizedBox(width: 16),
                        Text(notification.title),
                      ],
                    ),
                  ),
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
                        unawaited(ct.deleteNotification(notification.id));
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
                      notification.message ?? '',
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
                              ct.reSendNotification(
                                CreateNotificationDto.fromEntity(notification),
                                context,
                              );
                            }
                          });
                        },
                        child: const Text('Re-enviar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white),
          ],
        );
      },
      listaItems: ct.lista,
    );
  }
}
