import 'package:appwrite/models.dart';

abstract class AuthService {
  Future<void> initialization();

  Future<Session> createSession({
    required String email,
    required String password,
  });

  Future<Session> getSession();

  Future<String> getJwt();

  Future<User> updateName({required String name});

  Future<User> updatePassword({required String password, String oldPassword});

  Future<dynamic> deleteSession();

  Future<User> updatePrefs({required Map<dynamic, dynamic> prefs});

  Future<User> create({
    required String email,
    required String password,
    String? name,
  });
}
