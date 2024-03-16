import 'dart:async';

import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';

class NotificacaoController extends IController {
  final NotificacaoRepository _notificacaoRepository;

  NotificacaoController(this._notificacaoRepository);

  var lista = <Notificacao>[];

  @override
  void init(BuildContext context) {
    carregaNotificacao();
  }

  Future<void> carregaNotificacao() async {
    try {
      state = StatusBuild.loading;
      lista = await _notificacaoRepository.listDocument();
      state = StatusBuild.done;
    } on Exception catch (e) {
      handleErrorEvent(e);
      state = StatusBuild.erro;
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      state = StatusBuild.loading;
      await _notificacaoRepository.deletDocument(id: id);
      unawaited(carregaNotificacao());
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }

  Future<bool> reSendNotification(Notificacao entity) async {
    try {
      await _notificacaoRepository.createDocument(objeto: entity);
      return true;
    } on Exception catch (e) {
      handleErrorEvent(e);
      return false;
    }
  }
}
