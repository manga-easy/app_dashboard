import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/create_notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class SendNotificationController extends ManagerStore {
  final NotificacaoRepository _notificacaoRepository;
  final UsersRepository _usersRepository;

  SendNotificationController(
    this._notificacaoRepository,
    this._usersRepository,
  );
  User? test;
  CreateNotificationDto? nova;

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    final notificationId = arguments['id'];
    if (notificationId != 'create') {
      final result = await _notificacaoRepository.getDocument(
        id: notificationId,
      );
      if (result != null) {
        nova = CreateNotificationDto.fromEntity(result);
      }
    }
    nova ??= CreateNotificationDto.empty();
    state = StateManager.done;
  }

  void enviaNotificacao(context) => handleTry(
        call: () async {
          await _notificacaoRepository.createDocument(objeto: nova!);
          Navigator.pop(context);
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Mensagem enviada com sucesso',
            context: context,
          );
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );

  Future<void> enviaNotificacaoTest(context) => handleTry(
        call: () async {
          throw Exception('função desativada');
        },
        showDialogError: true,
        onCatch: StateManager.done,
      );

  Future<List<User>> pesquisaUser(String search) async {
    return _usersRepository.listDocument(
      search: search.isEmpty ? null : search,
    );
  }
}
