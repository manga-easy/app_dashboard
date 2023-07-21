import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

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
        const Text(
          'Detalhes',
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 300,
          width: 300,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  SelectableText(
                    'Tipo de autenticação: ${user.prefs.provider}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
