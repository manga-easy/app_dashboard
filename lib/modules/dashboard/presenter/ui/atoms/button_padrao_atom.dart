import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonPadraoAtom extends StatelessWidget {
  final String title;
  final IconData icone;
  final void Function()? onPress;
  final void Function()? onLongPress;

  const ButtonPadraoAtom({
    Key? key,
    this.onPress,
    required this.title,
    required this.icone,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding * 1.5,
          vertical: AppTheme.defaultPadding,
        ),
      ),
      onLongPress: onLongPress,
      onPressed: onPress,
      icon: Icon(icone),
      label: Text(title),
    );
  }
}
