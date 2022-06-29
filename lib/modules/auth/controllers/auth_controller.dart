import 'package:appwrite/models.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/credencial_model.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/models/erros_auth.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/credencial_repo.dart';
import 'package:dashboard_manga_easy/modules/dashboard/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart' as sdk;

class AuthController extends IController {
  final CredencialRepo credencialRepo;
  final Global gb;
  final AppwriteClient app;
  CredencialModel? credencialModel;
  var email = TextEditingController();
  var password = TextEditingController();

  AuthController({required this.gb, required this.app, required this.credencialRepo});

  @override
  void onClose() {
    email.dispose();
    password.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaCredencial();
  }

  void logar(context) async {
    try {
      Session response = await checkUsuario();
      await validacaoAdmin(response);
      gb.user = response.userId;
      salvaCredencial();
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.route,
        (route) => false,
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
    return await app.account.createSession(
      email: email.text,
      password: password.text,
    );
  }

  Future<void> validacaoAdmin(Session response) async {
    DocumentList result = await app.database.listDocuments(
      collectionId: sdk.Permissions.collectionId,
      queries: [
        Query.equal(
          'userId',
          response.userId,
        )
      ],
    );
    if (result.total <= 0) {
      throw Exception(ErrosAuth.isNotAdmin);
    }
  }

  void carregaCredencial() {
    var ret = credencialRepo.list();
    if (ret.isNotEmpty) {
      credencialModel = ret.first;
      email.text = credencialModel!.email;
    }
  }

  Future<void> salvaCredencial() async {
    var cred = CredencialModel(
      datetime: DateTime.now(),
      email: email.text,
    );
    await credencialRepo.put(objeto: cred);
  }
}
