import 'package:dashboard_manga_easy/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/config/app_theme.dart';
import 'package:dashboard_manga_easy/models/notificacao.dart';
import 'package:dashboard_manga_easy/services/appwrite.dart';
import 'package:dashboard_manga_easy/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/widgets/campo_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificacaoController extends GetxController {
  List lista = [].obs;
  Notificacao nova = Notificacao(menssege: '', titulo: '');
  final apiFcm = FCMApi();
  final app = Get.find<Appwrite>();
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    carregaNotificacao();
    super.onInit();
  }

  void carregaNotificacao() async {
    lista.clear();
    var retorno = await app.database.listDocuments(
      collectionId: Notificacao.collectionId,
    );
    for (var item in retorno.documents) {
      lista.add(Notificacao.fromJson(item.data));
    }
  }

  void enviaNotificacao() async {
    List<String?> tokens = [];
    var noti = await app.database.createDocument(
      documentId: 'unique()',
      collectionId: Notificacao.collectionId,
      data: nova.toJson(),
    );
    // for (var i = 0; i <= 0; i++) {
    //   tokens.clear();
    //   var retorno = await app.database.listDocuments(
    //     collectionId: Favorito.collectionID,
    //     limit: 100,
    //     offset: 100 * i,
    //   );
    //   List list = retorno.data['documents'];

    //   if (list.isEmpty) {
    //     break;
    //   }
    //   for (var item2 in list) {
    //     var favo = Favorito.fromJson(item2);
    //     var user = await app.users.get(userId: favo.idUser);
    //     tokens.add(Users.fromJson(user.data).prefs.tokenFcm);
    //   }

    apiFcm.postAviso(
      listtokens: tokens,
      msg: nova.menssege,
      title: nova.titulo,
      idmsg: noti.data['\$id'],
    );
    // Comunidade
    // Visite nossa comunidade do Discord
    await Future.delayed(Duration(seconds: 3));
    // }
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
}
