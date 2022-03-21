import 'package:dashboard_manga_easy/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/config/app_theme.dart';
import 'package:dashboard_manga_easy/models/emblema_user.dart';
import 'package:dashboard_manga_easy/models/notificacao.dart';
import 'package:dashboard_manga_easy/models/users.dart' as urs;
import 'package:dashboard_manga_easy/services/appwrite.dart';
import 'package:dashboard_manga_easy/services/global.dart';
import 'package:dashboard_manga_easy/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/widgets/campo_padrao.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersDetalhesController extends GetxController {
  final app = Get.find<Appwrite>();
  final gb = Get.find<Global>();
  var nova = Notificacao(menssege: '', titulo: '');
  urs.Users user = Get.arguments;
  List<EmblemaUser> emblemasUsers = [];
  final apiFcm = FCMApi();
  var indexP = 0.obs;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    carrega();
    super.onInit();
  }

  carrega() async {
    var retorno = await app.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [
        Query.equal('userId', user.id),
      ],
    );
    for (var item in retorno.documents) {
      emblemasUsers.add(
        EmblemaUser.fromJson(item.data),
      );
    }
  }

  void enviaNotificacao() async {
    List<String> tokens = [user.prefs.tokenFcm!];

    var noti = await app.database.createDocument(
      collectionId: Notificacao.collectionId,
      documentId: 'unique()',
      data: nova.toJson(),
    );
    await apiFcm.postMensagem(
      listtokens: tokens,
      msg: nova.menssege,
      title: nova.titulo,
      idmsg: noti.data['\$id'],
    );
  }

  Future<void> addEmblema(String idEmblema) async {
    print(idEmblema);
    var emble = await app.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [
        Query.equal('idEmblema', idEmblema),
        Query.equal('userId', user.id),
      ],
    );
    if (emble.documents.isEmpty) {
      var embUser = EmblemaUser(
        timeCria: DateTime.now().millisecondsSinceEpoch,
        userId: user.id,
        idEmblema: idEmblema,
      );
      await app.database.createDocument(
        documentId: 'unique()',
        collectionId: EmblemaUser.collectionId,
        data: embUser.toJson(),
        write: ['role:all'],
        read: ['role:all'],
      );
    } else {
      Get.defaultDialog(
        title: 'Já adquirido',
        content: Text(
          'Você já adquiriu o emblema',
        ),
      );
    }
  }

  void addNotificacao() {
    Get.bottomSheet(
      Container(
        color: AppTheme.bgColor,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Novo Aviso',
              style: Get.textTheme.headline6,
            ),
            SizedBox(height: 20),
            CampoPadrao(
              hintText: 'Digite o titulo',
              onChange: (v) => nova.titulo = v,
            ),
            SizedBox(height: 10),
            CampoPadrao(
              hintText: 'Digite a mensagem',
              onChange: (v) => nova.menssege = v,
            ),
            SizedBox(height: 20),
            ButtonPadrao(
              onPress: () => enviaNotificacao(),
              icone: Icons.send,
              title: "Enviar",
            )
          ],
        ),
      ),
    );
  }

  void showAddemblema() {
    Get.bottomSheet(
      Container(
        color: AppTheme.bgColor,
        child: Wrap(
          children: [
            Column(
              children: gb.listEmblema
                  .map(
                    (e) => TextButton(
                      child: Text(e.name),
                      onPressed: () => addEmblema(e.id),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
