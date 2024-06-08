import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_exception.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';

class AuthAppwriteService implements AuthService {
  late Account _account;
  String get ipserver => 'https://auth.lucas-cm.com.br/v1';
  String get projectID => '64372675b0f256f58f4f';

  AuthAppwriteService();

  @override
  Future<void> initialization() async {
    final Client client = Client();
    client.setEndpoint(ipserver).setProject(projectID).setSelfSigned();
    _account = Account(client);
  }

  @override
  Future<models.Session> createSession({
    required String email,
    required String password,
  }) async {
    try {
      return await _account.createEmailPasswordSession(
        email: email.trim(),
        password: password.trim(),
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<String> getJwt({String? sessionId}) async {
    try {
      final ret = await _account.createJWT();
      Helps.log(ret);
      return ret.jwt;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<models.User> updateName({required String name}) async {
    try {
      return await _account.updateName(name: name);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<models.User> updatePassword({
    required String password,
    String? oldPassword,
  }) async {
    try {
      return await _account.updatePassword(
          password: password, oldPassword: oldPassword);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteSession({String? sessionId}) async {
    try {
      return await _account.deleteSession(sessionId: sessionId ?? 'current');
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<models.User> updatePrefs(
      {required Map<dynamic, dynamic> prefs}) async {
    try {
      return await _account.updatePrefs(prefs: prefs);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<models.User> create({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      String? nameNull;
      // tiver quer merda por causa do appwrite n aceita ""
      if (name != null && name.isNotEmpty) {
        nameNull = name.trim();
      }
      return await _account.create(
        userId: 'unique()',
        email: email.trim(),
        password: password.trim(),
        name: nameNull,
      );
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<models.Session> getSession() async {
    try {
      return await _account.getSession(sessionId: 'current');
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(Object? e) {
    if (e is AppwriteException) {
      final message = e.message ?? '';
      if (message.contains('Invalid email')) {
        throw AuthException(
          'O e-mail fornecido é inválido',
        );
      }
      if (message.contains('Invalid password')) {
        throw AuthException(
          'A senha fornecida é inválida',
        );
      }
      throw AuthException(_mapErrorTypes[e.type ?? ''] ?? e.toString());
    }
  }

  Map<String, String> get _mapErrorTypes => {
        'general_rate_limit_exceeded':
            'Você atingiu o limite máximo de solicitações para este recurso no momento.'
                ' Por favor, tente novamente mais tarde.',
        'user_email_already_exists': 'Já existe um usuário com o mesmo e-mail.',
        'user_already_exists': 'Já existe um usuário com o mesmo e-mail.',
        'user_unauthorized':
            'O usuário atual não está autorizado a executar a ação solicitada.',
        'user_invalid_credentials':
            'Credenciais inválidas. Por favor, verifique o e-mail e a senha.🦄',
        'user_invalid_token':
            'Token inválido. Por favor, verifique e tente novamente.😥',
        'user_blocked': 'O usuário atual foi bloqueado.😥',
        'user_password_mismatch':
            'As senhas não coincidem. Verifique a senha e confirme a senha.🦄',
      };
}
