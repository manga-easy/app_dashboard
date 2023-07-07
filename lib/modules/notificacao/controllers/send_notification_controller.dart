import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class SendNotificationController extends IController {
  final NotificacaoRepository _notificacaoRepository;

  SendNotificationController(
    this._notificacaoRepository,
  );
  User? test;
  Notificacao? nova;

  @override
  void init(BuildContext context) {
    nova = Notificacao.empty();
  }

  Future<void> enviaNotificacao(context) async {
    try {
      if (nova == null) {
        return;
      }
      await _notificacaoRepository.sendMessage(objeto: nova!);

      Navigator.pop(context);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Mensagem enviada com sucesso',
        context: context,
      );
    } on Exception catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
    }
  }

  Future<void> enviaNotificacaoTest(context) async {
    try {
      if (test == null) {
        throw Exception('Escolha um usuario para testar a notificação');
      }
      throw UnimplementedError();

      // if (ret.isSend) {
      //   AppHelps.confirmaDialog(
      //     title: 'Sucesso',
      //     content: 'Mensagem enviada com sucesso',
      //     context: context,
      //   );
      // } else {
      //   AppHelps.confirmaDialog(
      //     title: 'Erro',
      //     content: 'Mensagem não foi enviada',
      //     context: context,
      //   );
      // }
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
