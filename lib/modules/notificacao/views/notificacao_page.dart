import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
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
    return Scaffold(
      drawer: const SideMenu(atual: NotificacaoPage.route),
      appBar: AppBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: ct.status,
          builder: (context, value, child) {
            if (ct.status.value == StatusBuild.loading) {
              return const LoadingAtom();
            }
            return Column(
              children: [
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: ct.carregaNotificacao, child: const Text('Atualiza')),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.defaultPadding * 1.5,
                          vertical: AppTheme.defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () => ct.addNotificacao(context),
                      icon: const Icon(Icons.send),
                      label: const Text("Enviar notificação"),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ct.lista.value.length,
                    itemBuilder: (context, index) {
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
