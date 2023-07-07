import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class NotificacaoRepositoryV1 implements NotificacaoRepository {
  final ApiMonolito _apiMonolito;

  NotificacaoRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'notifications';
  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete(endpoint: '$version/$feature/$id');
  }

  @override
  Future<Notificacao?> getDocument({required String id}) async {
    try {
      final ret = await _apiMonolito.get(endpoint: '$version/$feature/$id');
      if (ret.data.isEmpty) {
        return null;
      }
      return NotificationDto.fromMap(ret.data.first).toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDocument({required Notificacao objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature',
      body: NotificationDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<Notificacao>> listDocument({FiltroNotificacao? where}) async {
    final ret = await _apiMonolito.get(
      endpoint: '$version/$feature/list',
    );
    return ret.data.map((e) => NotificationDto.fromMap(e).toEntity()).toList();
  }

  @override
  Future<void> sendMessage({required Notificacao objeto}) async {
    await _apiMonolito.post(
      endpoint: '$version/$feature/send-message',
      body: NotificationDto.fromEntity(objeto).toMap(),
    );
  }
}
