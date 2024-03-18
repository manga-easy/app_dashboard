import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/filtro_notificacao.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';

abstract interface class NotificacaoRepository {
  Future<void> createDocument({required Notificacao objeto});

  Future<void> deletDocument({required String id});

  Future<Notificacao?> getDocument({required String id});

  Future<List<Notificacao>> listDocument({FiltroNotificacao? where});
}
