import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:manga_easy_sdk/src/services/api_response_parse/result_entity.dart';

class ApiMonolito {
  final ApiResponseParser _apiResponseParser;
  final ClientRequest _clientRequest;
  final AuthService _authService;
  final String _host = 'http://192.168.15.8:8080';

  ApiMonolito(this._clientRequest, this._apiResponseParser, this._authService);
  Map<String, dynamic> getHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<ResultEntity> get({required String endpoint}) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.get(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }

  Future<ResultEntity> delete({required String endpoint}) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.delete(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }

  Future<ResultEntity> post({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.post(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
      body: body,
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }

  Future<ResultEntity> put({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.put(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
      body: body,
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }
}
