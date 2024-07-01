import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';

class NotificacaoRepositoryV1 implements NotificacaoRepository {
  final ApiMonolith _apiMonolito;

  NotificacaoRepositoryV1(this._apiMonolito);

  String get version => 'v1';
  String get feature => 'notifications';
  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$version/$feature/$id');
  }

  @override
  Future<Notificacao?> getDocument({required String id}) async {
    try {
      final result = await _apiMonolito.get('$version/$feature/$id');
      if (result.isEmpty) {
        return null;
      }
      return NotificationDto.fromMap(result.first).toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Notificacao>> listDocument({FiltroNotificacao? where}) async {
    final result = await _apiMonolito.get(
      '$version/$feature/list',
    );
    return (result as List)
        .map<Notificacao>((e) => NotificationDto.fromMap(e).toEntity())
        .toList();
  }

  @override
  Future<void> createDocument({required Notificacao objeto}) async {
    await _apiMonolito.post(
      '$version/$feature',
      body: NotificationDto.fromEntity(objeto).toMap(),
    );
  }
}
