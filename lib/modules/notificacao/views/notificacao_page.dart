import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/templates/modulo_page_template.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/notificacao_controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/send_notification_page.dart';
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
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        return ModuloPageTemplate(
          route: NotificacaoPage.route,
          statusBuild: ct.state,
          onPressedAtualiza: ct.carregaNotificacao,
          onPressedNovoItem: () =>
              Navigator.pushNamed(context, SendNotificationPage.route),
          labelNovoItem: "Enviar notificação",
          itemBuilderLista: (context, index) {
            var use = ct.lista.value[index];
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Text(
                        use.titulo.substring(0, use.titulo.length > 1 ? 1 : 0)),
                  ),
                  title: Text(use.titulo),
                  subtitle: Text(
                    use.menssege,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () => ct.removePermissoes(use.id!, context),
                  ),
                ),
                use.image.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Image.network(
                          use.image,
                        ),
                      )
                    : const SizedBox()
              ],
            );
          },
          listaItems: ct.lista.value,
        );
      },
    );
  }
}
