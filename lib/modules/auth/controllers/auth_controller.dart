import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
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

  logar() async {
    try {
      await app.account.createSession(
        email: email.text,
        password: password.text,
      );
      Get.offAllNamed(MainScreen.router);
    } catch (e) {
      Get.defaultDialog(
        title: 'Erro ao realizar o login',
        middleText: 'Verifique seus dados!\n$e',
      );
    }
  }
}
