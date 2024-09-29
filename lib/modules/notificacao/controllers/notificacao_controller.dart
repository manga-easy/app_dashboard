import 'dart:async';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/create_notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:page_manager/export_manager.dart';

class NotificacaoController extends ManagerStore {
  final NotificacaoRepository _notificacaoRepository;

  NotificacaoController(this._notificacaoRepository);

  var lista = <Notificacao>[];

  @override
  void init(Map<String, dynamic> arguments) {
    carregaNotificacao();
  }

  Future<void> carregaNotificacao() async {
    try {
      state = StateManager.loading;
      lista = await _notificacaoRepository.listDocument();
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
      rethrow;
    }
  }

  Future<void> deleteNotification(String id) => handleTry(
        call: () async {
          await _notificacaoRepository.deletDocument(id: id);
          await carregaNotificacao();
        },
      );

  void reSendNotification(CreateNotificationDto entity, context) => handleTry(
        call: () async {
          await _notificacaoRepository.createDocument(objeto: entity);
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Mensagem enviada com sucesso',
            context: context,
          );
        },
      );
}
