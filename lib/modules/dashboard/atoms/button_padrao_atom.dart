import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonPadraoAtom extends StatelessWidget {
  final String title;
  final IconData icone;
  final void Function()? onPress;

  ButtonPadraoAtom({
    this.onPress,
    required this.title,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.defaultPadding * 1.5,
          vertical: AppTheme.defaultPadding,
        ),
      ),
      onPressed: onPress,
      icon: Icon(icone),
      label: Text(title),
    );
  }
}
