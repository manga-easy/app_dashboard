import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final ct = di.get<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: [
            SizedBox(height: AppTheme.defaultPadding),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
