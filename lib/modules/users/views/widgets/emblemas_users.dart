import 'package:dashboard_manga_easy/modules/users/controllers/detalhes_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasUsersW extends StatelessWidget {
  final UsersDetalhesController ct;
  final List<EmblemaUser> list;

  const EmblemasUsersW({Key? key, required this.list, required this.ct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var emb = ct.listEmblema.firstWhere((element) => element.id == list[index].idEmblema);
        return Row(
          children: [Text(emb.name)],
        );
      },
    );
  }
}
