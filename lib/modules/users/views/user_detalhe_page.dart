import 'package:dashboard_manga_easy/modules/users/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/views/widgets/emblemas_users.dart';
import 'package:dashboard_manga_easy/modules/users/views/widgets/info_users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetalhesPage extends GetView {
  final ct = Get.put(UsersDetalhesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ct.user.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ct.showAddemblema,
        label: Text('Adicionar emblema'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: DefaultTabController(
                length: 3,
                child: TabBar(
                  onTap: (v) => ct.indexP.value = v,
                  tabs: [
                    Tab(text: 'Geral'),
                    Tab(text: 'Emblemas'),
                    Tab(text: 'não sei ainda'),
                  ],
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: [
                  InfoUsersW(
                    email: ct.user.email,
                    id: ct.user.id,
                    onPress: () => ct.addNotificacao(),
                  ),
                  EmblemasUsersW(ct.emblemasUsers),
                  EmblemasUsersW(ct.emblemasUsers),
                ].elementAt(ct.indexP.value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
