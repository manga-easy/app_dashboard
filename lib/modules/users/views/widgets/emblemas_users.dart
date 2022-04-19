import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasUsersW extends GetView {
  final gb = Get.find<Global>();
  final List<EmblemaUser> list;

  EmblemasUsersW(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var emb = gb.listEmblema.firstWhere((element) => element.id == list[index].idEmblema);
        return Row(
          children: [Text(emb.name)],
        );
      },
    );
  }
}
