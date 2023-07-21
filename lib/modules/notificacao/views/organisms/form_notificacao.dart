import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/notificacao/controllers/send_notification_controller.dart';
import 'package:flutter/material.dart';

class FormNotificacao extends StatelessWidget {
  final SendNotificationController controller;
  const FormNotificacao({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            'Novo Aviso',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20),
          CampoPadraoAtom(
            hintText: 'Digite o titulo',
            onChange: (v) => controller.nova!.titulo = v,
          ),
          const SizedBox(height: 10),
          CampoPadraoAtom(
            hintText: 'Digite a mensagem',
            onChange: (v) => controller.nova!.menssege = v,
          ),
          const SizedBox(height: 10),
          CampoPadraoAtom(
            hintText: 'Digite o link',
            onChange: (v) => controller.nova!.image = v,
          ),
          const SizedBox(height: 20),
          ButtonPadraoAtom(
            onPress: () {
              final result = AppHelps.confirmaDialog(
                title: 'Deseja enviar notificação ?',
                context: context,
              );
              result.then((value) {
                if (value) {
                  controller.enviaNotificacao(context);
                }
              });
            },
            icone: Icons.send,
            title: 'Enviar',
          )
        ],
      ),
    );
  }
}
