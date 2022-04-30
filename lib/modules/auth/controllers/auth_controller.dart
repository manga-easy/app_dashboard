import 'package:appwrite/models.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/auth/models/erros_auth.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart' as sdk;

class AuthController extends IController {
  final Global gb;
  final AppwriteClient app;

  var email = TextEditingController();
  var password = TextEditingController();

  AuthController({required this.gb, required this.app});

  @override
  void onClose() {
    email.dispose();
    password.dispose();
  }

  @override
  void onInit(BuildContext context) {}

  void logar(context) async {
    try {
      Session response = await checkUsuario();
      await validacaoAdmin(response);
      gb.user = response.userId;
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainScreen.router,
        (route) => true,
      );
    } catch (e) {
      sdk.Helps.log(e);
      AppHelps.confirmaDialog(
        title: ErrosAuth.erroLogin,
        content: e.toString(),
        context: context,
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
      collectionId: sdk.User.collectionIdAdmin,
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
