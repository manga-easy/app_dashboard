import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class NotificacaoScreen extends GetView {
  final ct = Get.put(NotificacaoController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppTheme.defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.defaultPadding * 1.5,
                  vertical: AppTheme.defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () => ct.addNotificacao(),
              icon: Icon(Icons.send),
              label: Text("Enviar notificação"),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ct.lista.length,
            itemBuilder: (context, index) {
              Notificacao use = ct.lista[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  child: Text(use.titulo.substring(0, use.titulo.length > 1 ? 1 : 0)),
                ),
                title: Text(use.titulo),
                subtitle: Text(
                  use.menssege,
                  style: Get.textTheme.subtitle1!.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
