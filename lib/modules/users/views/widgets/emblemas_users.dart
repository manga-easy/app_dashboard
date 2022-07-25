import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/detalhes_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasUsersW extends StatelessWidget {
  final UsersDetalhesController ct;
  final List<EmblemaUser> list;

  const EmblemasUsersW({Key? key, required this.list, required this.ct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          var userEmblema = list[index];
          var emb = ct.listEmblema.firstWhere((element) => element.id == userEmblema.idEmblema);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  emb.url,
                  width: 50,
                  height: 50,
                ),
                Text(
                  emb.name,
                ),
                Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.fromMillisecondsSinceEpoch(userEmblema.timeCria),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
