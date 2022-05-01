import 'package:dashboard_manga_easy/core/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class NotificacaoController extends IController {
  final AppwriteAdmin app = di();
  final apiFcm = FCMApi();
  var nova = Notificacao(menssege: '', titulo: '');
  var lista = ValueNotifier(<Notificacao>[]);
  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    carregaNotificacao();
  }

  void carregaNotificacao() async {
    lista.value.clear();
    var retorno = await app.database.listDocuments(
      collectionId: Notificacao.collectionId,
    );
    lista.value = retorno.documents.map((e) => Notificacao.fromJson(e.data)).toList();
  }

  void enviaNotificacao() async {
    var noti = await app.database.createDocument(
      documentId: 'unique()',
      collectionId: Notificacao.collectionId,
      data: nova.toJson(),
    );
    apiFcm.postAviso(
      msg: nova.menssege,
      title: nova.titulo,
      idmsg: noti.data['\$id'],
    );
  }

  void addNotificacao(context) {
    AppHelps.bottomSheet(
      context: context,
      isScrollControlled: true,
      child: Container(
        color: AppTheme.bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Novo Aviso',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            CampoPadraoAtom(
              hintText: 'Digite o titulo',
              onChange: (v) => nova.titulo = v,
            ),
            const SizedBox(height: 10),
            CampoPadraoAtom(
              hintText: 'Digite a mensagem',
              onChange: (v) => nova.menssege = v,
            ),
            const SizedBox(height: 20),
            ButtonPadraoAtom(
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
