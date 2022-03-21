import 'package:dashboard_manga_easy/config/app_theme.dart';
import 'package:dashboard_manga_easy/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final ct = DashboardController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: [
            SizedBox(height: AppTheme.defaultPadding),
            // Row(
            //   children: [
            //     ButtonPadrao(
            //       title: 'Rodar script notficação',
            //       icone: Icons.event_seat,
            //       onPress: () async {
            //         for (var item in [MuitoManga(), MangaHost()]) {
            //           await BackgroundService.notificaCapitulosNovos(item);
            //         }
            //       },
            //     )
            //   ],
            // ),
            Row(
              children: [
                // ButtonPadrao(
                //   title: 'resetar xp',
                //   icone: Icons.upcoming,
                //   onPress: ct.resetarxp,
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
