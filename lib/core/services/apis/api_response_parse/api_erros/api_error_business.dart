import 'package:dashboard_manga_easy/core/services/apis/api_response_parse/api_erros/api_error.dart';

class ApiErrorBusiness extends ApiError {
  @override
  String message;
  ApiErrorBusiness({
    required this.message,
  });
}
