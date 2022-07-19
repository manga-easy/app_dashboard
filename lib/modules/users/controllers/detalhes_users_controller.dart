import 'package:api_fcm/api_fcm.dart';
import 'package:dashboard_manga_easy/core/config/app_config.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UsersDetalhesController extends IController {
  final AppwriteAdmin app;
  final Global gb;
  final ApiFcm apiFcm = ApiFcm(tokenServer: AppConfig.tokenServer);
  var status = ValueNotifier(StatusBuild.loading);
  var nova = Notificacao(
    menssege: '',
    titulo: '',
    dateMade: DateTime.now().millisecondsSinceEpoch,
    image: '',
  );
  User? user;
  List<EmblemaUser> emblemasUsers = [];
  List<Emblema> listEmblema = [];
  var indexP = ValueNotifier(0);

  UsersDetalhesController({
    required this.app,
    required this.gb,
  });

  @override
  void onClose() {
    indexP.dispose();
  }

  @override
  void onInit(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User;
    carrega();
    carregaEmblemas();
  }

  void carrega() async {
    var retorno = await app.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [
        Query.equal('userId', user!.id),
      ],
    );
    for (var item in retorno.documents) {
      emblemasUsers.add(
        EmblemaUser.fromJson(item.data),
      );
    }
    status.value = StatusBuild.done;
  }

  void enviaNotificacao() async {
    List<String> tokens = [user!.prefs.tokenFcm];

    await app.database.createDocument(
      collectionId: Notificacao.collectionId,
      documentId: 'unique()',
      data: nova.toJson(),
    );
    await apiFcm.postMessage(
      listtokens: tokens,
      notification: MessageModel(
        body: nova.menssege,
        title: nova.titulo,
        image: nova.image,
      ),
    );
  }

  Future<void> addEmblema(String idEmblema, BuildContext context) async {
    var emble = await app.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [
        Query.equal('idEmblema', idEmblema),
        Query.equal('userId', user!.id),
      ],
    );
    if (emble.documents.isEmpty) {
      var embUser = EmblemaUser(
        timeCria: DateTime.now().millisecondsSinceEpoch,
        userId: user!.id!,
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
      AppHelps.confirmaDialog(
        title: 'Já adquirido',
        content: 'Você já adquiriu o emblema',
        context: context,
      );
    }
  }

  void addNotificacao(BuildContext context) {
    AppHelps.bottomSheet(
      context: context,
      child: Container(
        color: AppTheme.bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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

  void showAddemblema(BuildContext context) {
    AppHelps.bottomSheet(
      context: context,
      child: Container(
        color: AppTheme.bgColor,
        child: Wrap(
          children: [
            Column(
              children: listEmblema
                  .map(
                    (e) => TextButton(
                      child: Text(e.name),
                      onPressed: () => addEmblema(e.id!, context),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  void carregaEmblemas() async {
    listEmblema.clear();
    var retorno = await app.database.listDocuments(limit: 100, collectionId: Emblema.collectionId);
    listEmblema = retorno.documents.map((e) => Emblema.fromJson(e.data)).toList();
  }
}
