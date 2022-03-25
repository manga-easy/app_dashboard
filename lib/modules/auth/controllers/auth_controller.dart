import 'package:appwrite/models.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final gb = Get.find<Global>();
  final app = Get.find<AppwriteClient>();

  final erros = {
    'login': 'Erro ao realizar o login',
    'auth': 'Dados incorretos, verifique seus dados',
    'admin': 'Você não é um administrador',
  };

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
      Session response = await checkUsuario();
      await validacaoAdmin(response);
      Get.offAllNamed(MainScreen.router);
    } catch (e) {
      Get.defaultDialog(
        title: '${erros['login']}',
        middleText: '$e',
      );
    }
  }

  checkUsuario() async {
    try {
      return await app.account.createSession(
        email: email.text,
        password: password.text,
      );
    } catch (e) {
      throw new Exception(erros['auth']);
    }
  }

  validacaoAdmin(Session response) async {
    DocumentList result = await app.database.listDocuments(
      collectionId: '623d1373e64ea01b85c0',
      queries: [
        Query.equal(
          'userId',
          response.userId,
        )
      ],
    );
    if (result.total <= 0) {
      throw new Exception(erros['admin']);
    }
  }
}
