import 'package:dashboard_manga_easy/core/libraries/api_response_parse/api_erros/api_error.dart';

class ApiForbiddenError implements ApiError {
  @override
  String message = 'Acesso negado';
}
