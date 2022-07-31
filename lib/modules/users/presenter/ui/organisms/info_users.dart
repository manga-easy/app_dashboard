import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class InfoUsersW extends StatelessWidget {
  final User user;
  final void Function()? onPress;

  const InfoUsersW({
    super.key,
    required this.user,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalhes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 300,
          width: 300,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 45,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SelectableText('Name ${user.name}'),
                  const SizedBox(height: 5),
                  SelectableText('Email: ${user.email}'),
                  const SizedBox(height: 5),
                  SelectableText(user.id!),
                  const SizedBox(height: 5),
                  SelectableText("Tipo de autenticação: ${user.prefs.provider}"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
