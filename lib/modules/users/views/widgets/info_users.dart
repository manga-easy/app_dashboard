import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoUsersW extends GetView {
  final String email;
  final String id;
  final void Function()? onPress;

  InfoUsersW({required this.email, required this.id, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 15),
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
        ButtonPadrao(
          title: 'Enviar Notificação',
          icone: Icons.send,
          onPress: onPress,
        ),
        ButtonPadrao(
          title: 'Resetar senha',
          icone: Icons.password,
        ),
      ],
    );
  }
}
