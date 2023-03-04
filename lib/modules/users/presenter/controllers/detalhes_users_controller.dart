import 'package:api_fcm/api_fcm.dart';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';

import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblema_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UsersDetalhesController extends IController {
  final AppwriteAdmin app;
  final EmblemaUserRepository emblemaUserRepository;
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
  var listXps = ValueNotifier(<NivelUser>[]);
  var indexP = ValueNotifier(0);

  UsersDetalhesController({
    required this.app,
    required this.gb,
    required this.emblemaUserRepository,
  });

  @override
  void dispose() {
    super.dispose();
    indexP.dispose();
  }

  @override
  Future<void> init(BuildContext context) async {
    user = ModalRoute.of(context)!.settings.arguments as User;
    carregaXpsUser();
    await carrega();
    await carregaEmblemas();
    status.value = StatusBuild.done;
  }

  Future<void> carrega() async {
    var retorno = await app.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [
        Query.equal('userId', user!.id),
      ],
    );
    emblemasUsers =
        retorno.documents.map((e) => EmblemaUser.fromJson(e.data)).toList();
    emblemasUsers = emblemasUsers.reversed.toList();
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
    status.value = StatusBuild.loading;
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
      await carrega();
      status.value = StatusBuild.done;
    } else {
      status.value = StatusBuild.done;
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

  Future<List<Emblema>> carregaEmblemas([String pesquisa = '']) async {
    listEmblema.clear();
    var retorno = await app.database.listDocuments(
      limit: 100,
      collectionId: Emblema.collectionId,
    );
    listEmblema =
        retorno.documents.map((e) => Emblema.fromJson(e.data)).toList();
    listEmblema.removeWhere((element) =>
        !element.name.toLowerCase().contains(pesquisa.toLowerCase()));
    return listEmblema;
  }

  Future<void> carregaXpsUser() async {
    var retorno = await app.database.listDocuments(
      limit: 100,
      collectionId: NivelUser.collectionId,
      queries: [
        Query.equal('userId', user!.id!),
      ],
      orderAttributes: ['\$id'],
      orderTypes: ['DESC'],
    );
    listXps.value =
        retorno.documents.map((e) => NivelUser.fromJson(e.data)).toList();
  }

  Future<void> removerEmblema(String id, BuildContext context) async {
    var ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: '',
      context: context,
    );
    if (ret) {
      status.value = StatusBuild.loading;
      await emblemaUserRepository.deletDocument(id: id);
      await carrega();
      status.value = StatusBuild.done;
    }
  }
}
