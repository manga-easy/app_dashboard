import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';

abstract interface class UsersRepository {
  Future<User?> getDocument({required String id});

  Future<void> updateDocument({required User objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required User objeto});

  Future<List<User>> listDocument({String? search});
}
