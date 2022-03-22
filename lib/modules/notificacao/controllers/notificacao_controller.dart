import 'package:dashboard_manga_easy/core/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/campo_padrao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/models/notificacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificacaoController extends GetxController {
  List lista = [].obs;
  Notificacao nova = Notificacao(menssege: '', titulo: '');
  final apiFcm = FCMApi();
  final app = Get.find<AppwriteAdmin>();
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
    apiFcm.postAviso(
      listtokens: tokens,
      msg: nova.menssege,
      title: nova.titulo,
      idmsg: noti.data['\$id'],
    );

    await Future.delayed(Duration(seconds: 3));
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
