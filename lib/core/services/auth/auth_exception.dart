import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class AuthException implements ApiError {
  @override
  final String message;

  AuthException(this.message);
}
