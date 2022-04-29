import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonPadrao extends GetView {
  final String title;
  final IconData icone;
  final void Function()? onPress;

  ButtonPadrao({
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
