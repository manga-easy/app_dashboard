import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:flutter/material.dart';

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
      valueListenable: ct.status,
      builder: (context, value, child) {
        return ModuloPageTemplate(
          route: NotificacaoPage.route,
          statusBuild: ct.status.value,
          onPressedAtualiza: ct.carregaNotificacao,
          onPressedNovoItem: () => ct.addNotificacao(context),
          labelNovoItem: "Enviar notificação",
          itemBuilderLista: (context, index) {
            var use = ct.lista.value[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 35,
                child: Text(use.titulo.substring(0, use.titulo.length > 1 ? 1 : 0)),
              ),
              title: Text(use.titulo),
              subtitle: Text(
                use.menssege,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
              ),
            );
          },
          listaItems: ct.lista.value,
        );
      },
    );
  }
}
