import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:flutter/material.dart';

class InfoUsersW extends StatelessWidget {
  final String email;
  final String id;
  final void Function()? onPress;

  const InfoUsersW({
    Key? key,
    required this.email,
    required this.id,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: $email'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(id),
          ],
        ),
        ButtonPadraoAtom(
          title: 'Enviar Notificação',
          icone: Icons.send,
          onPress: onPress,
        ),
        const ButtonPadraoAtom(
          title: 'Resetar senha',
          icone: Icons.password,
        ),
      ],
    );
  }
}
