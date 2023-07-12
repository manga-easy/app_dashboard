import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract interface class UsersRepository {
  Future<User?> getDocument({required String id});

  Future<void> updateDocument({required User objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required User objeto});

  Future<List<User>> listDocument({String? search});
}
