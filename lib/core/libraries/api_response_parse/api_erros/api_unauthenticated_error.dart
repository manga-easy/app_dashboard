import 'package:dashboard_manga_easy/core/libraries/api_response_parse/api_erros/api_error.dart';

class ApiUnauthenticatedError implements ApiError {
  @override
  String message = 'Usuario não autenticado';
}
