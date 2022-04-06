import 'package:appwrite/models.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/auth/models/erros_auth.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:dashboard_manga_easy/modules/users/models/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final gb = Get.find<Global>();
  final app = Get.find<AppwriteClient>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void logar() async {
    try {
      Session response = await checkUsuario();
      await validacaoAdmin(response);
      gb.user = response.userId;
      Get.offAllNamed(MainScreen.router);
    } catch (e) {
      AppHelps.log(e);
      Get.defaultDialog(
        title: '${ErrosAuth.erroLogin}',
        middleText: '$e',
      );
    }
  }

  Future<Session> checkUsuario() async {
    try {
      return await app.account.createSession(
        email: email.text,
        password: password.text,
      );
    } catch (e) {
      throw new Exception(ErrosAuth.erroLogin);
    }
  }

  Future<void> validacaoAdmin(Session response) async {
    DocumentList result = await app.database.listDocuments(
      collectionId: UsersL.collectionIdAdmin,
      queries: [
        Query.equal(
          'userId',
          response.userId,
        )
      ],
    );
    if (result.total <= 0) {
      throw new Exception(ErrosAuth.isNotAdmin);
    }
  }
}
