import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:dashboard_manga_easy/modules/users/controllers/users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/models/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends GetView {
  static const router = '/users';
  final ct = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppTheme.defaultPadding),
        CampoPadrao(
          onChange: (p) => ct.pesquisa.value = p,
          onEditComplet: () => ct.pesquisaUser(),
        ),
        SizedBox(height: AppTheme.defaultPadding),
        Expanded(
          child: Obx(
            () => ct.lista.length != 0
                ? ListView.builder(
                    itemCount: ct.lista.length,
                    itemBuilder: (context, index) {
                      UsersL use = ct.lista[index];
                      return ListTile(
                        onTap: () => Get.toNamed('/dealhes.users', arguments: use),
                        leading: CircleAvatar(
                          radius: 35,
                          child: Text(use.name.substring(0, use.name.length > 1 ? 1 : 0)),
                        ),
                        title: Text(use.name),
                        subtitle: Text(
                          use.email,
                          style: Get.textTheme.subtitle1!.copyWith(color: Colors.white),
                        ),
                      );
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
