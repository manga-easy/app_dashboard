import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_user_params.dart';

abstract interface class EmblemaUserRepository {
  Future<void> creatDocument({required EmblemaUser objeto});

  Future<void> deletDocument({
    required String idEmblema,
    required String userID,
  });

  Future<EmblemaUser?> getDocument({
    required String idEmblema,
    required String userID,
  });

  Future<void> updateDocument({required EmblemaUser objeto});

  Future<List<EmblemaUser>> listDocument({required EmblemaUserParams where});
}
