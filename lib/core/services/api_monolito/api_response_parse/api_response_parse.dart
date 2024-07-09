import 'package:dashboard_manga_easy/core/libraries/client/response_request_entity.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_erros/api_error_business.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_erros/api_forbidden_error.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_erros/api_internal_server_error.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_erros/api_unauthenticated_error.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_erros/api_unknown_error.dart';

class ApiResponseParser {
  dynamic handleResponse(ResponseRequestEntity response) {
    switch (response.statusCode) {
      case 401:
        throw ApiUnauthenticatedError();
      case 403:
        throw ApiForbiddenError();
      case 422:
        throw ApiErrorBusiness(message: response.data['message']);
      case 500:
        throw ApiInternalServerError(message: response.statusMessage);
      case 0:
        throw ApiUnknownError(message: response.statusMessage);
    }

    if (response.data['status'] == 'ERROR') {
      throw ApiErrorBusiness(message: response.data['message']);
    }
    return response.data['data'] ?? response.data;
  }
}
