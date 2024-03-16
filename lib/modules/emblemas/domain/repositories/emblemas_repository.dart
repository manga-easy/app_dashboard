import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';

abstract interface class EmblemasRepository {
  Future<void> creatDocument({required Emblema objeto});

  Future<void> deletDocument({required String id});

  Future<Emblema?> getDocument({required String id});

  Future<void> updateDocument({required Emblema objeto});

  Future<List<Emblema>> listDocument({EmblemaParams? where});
}
