import 'package:api_fcm/api_fcm.dart';
import 'package:dashboard_manga_easy/core/config/app_config.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repository_external.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class SendNotificationController extends ValueNotifier implements IController {
  final ApiFcm apiFcm = ApiFcm(tokenServer: AppConfig.tokenServer);
  final NotificacaoRepository notificacaoRepository;
  final UserRepositoryExternal userRepo;
  User? test;
  var nova = Notificacao(
    menssege: '',
    titulo: '',
    dateMade: DateTime.now().millisecondsSinceEpoch,
    image: '',
  );
  SendNotificationController({required this.notificacaoRepository, required this.userRepo}) : super(null);

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onInit(BuildContext context) {
    // TODO: implement onInit
  }

  void enviaNotificacao(context) async {
    await notificacaoRepository.creatDocument(objeto: nova);
    var ret = await apiFcm.postTopics(
      topics: 'avisos',
      notification: MessageModel(
        body: nova.menssege,
        title: nova.titulo,
        image: nova.image,
      ),
    );

    if (ret.isSend) {
      Navigator.pop(context);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Mensagem enviada com sucesso',
        context: context,
      );
    } else {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: 'Mensagem não foi enviada',
        context: context,
      );
    }
  }

  void enviaNotificacaoTest(context) async {
    try {
      if (test == null) {
        throw Exception('Escolha um usuario para testar a notificação');
      }
      var ret = await apiFcm.postMessage(
        listtokens: [test!.prefs.tokenFcm],
        notification: MessageModel(
          body: nova.menssege,
          title: nova.titulo,
          image: nova.image,
        ),
      );

      if (ret.isSend) {
        AppHelps.confirmaDialog(
          title: 'Sucesso',
          content: 'Mensagem enviada com sucesso',
          context: context,
        );
      } else {
        AppHelps.confirmaDialog(
          title: 'Erro',
          content: 'Mensagem não foi enviada',
          context: context,
        );
      }
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }

  Future<List<User>> pesquisaUser(String pesquisa) async {
    return await userRepo.list(search: pesquisa);
  }
}
