import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: const [
            SizedBox(height: AppTheme.defaultPadding),
          ],
        ),
      ),
    );
  }
}
