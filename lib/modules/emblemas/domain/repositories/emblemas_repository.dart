import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract interface class EmblemasRepository {
  Future<void> creatDocument({required Emblema objeto});

  Future<void> deletDocument({required String id});

  Future<Emblema?> getDocument({required String id});

  Future<void> updateDocument({required Emblema objeto});

  Future<List<Emblema>> listDocument({EmblemaParams? where});
}
