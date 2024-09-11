import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/notificacao/data/dtos/create_notification_dto.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';

class NotificacaoRepositoryV1 implements NotificacaoRepository {
  final ApiMonolith _apiMonolito;

  NotificacaoRepositoryV1(this._apiMonolito);

  String get feature => 'notifications';
  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$feature/v1/$id');
  }

  @override
  Future<Notificacao?> getDocument({required String id}) async {
    try {
      final result = await _apiMonolito.get('$feature/v1/$id');
      if (result.isEmpty) {
        return null;
      }
      return Notificacao.fromMap(result.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Notificacao>> listDocument({FiltroNotificacao? where}) async {
    final result = await _apiMonolito.get(
      '$feature/v1',
    );
    return (result as List)
        .map<Notificacao>((e) => Notificacao.fromMap(e))
        .toList();
  }

  @override
  Future<void> createDocument({required CreateNotificationDto objeto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: objeto.toMap(),
    );
  }
}
