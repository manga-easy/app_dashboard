import 'package:dashboard_manga_easy/modules/users/domain/entities/levels_user_filter.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract interface class LevelsUserRepository {
  Future<void> creatDocument({required NivelUser objeto});

  Future<void> deletDocument({required String id});

  Future<NivelUser?> getDocument({required String id});

  Future<void> updateDocument({required NivelUser objeto});

  Future<List<NivelUser>> listDocument({required LevelsUserFilter where});
}
