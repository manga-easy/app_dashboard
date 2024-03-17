import 'package:dashboard_manga_easy/core/libraries/api_response_parse/api_response_parse.dart';
import 'package:dashboard_manga_easy/core/libraries/api_response_parse/result_entity.dart';
import 'package:dashboard_manga_easy/core/libraries/client/cliente_request.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:flutter/foundation.dart';

class ApiMonolito {
  final ApiResponseParser _apiResponseParser;
  final ClientRequest _clientRequest;
  final AuthService _authService;
  final String _host =
      kDebugMode ? 'http://localhost:8080' : 'https://monolito.lucas-cm.com.br';

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
    return _apiResponseParser.handleResponse(result);
  }

  Future<ResultEntity> delete({required String endpoint}) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.delete(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
    );
    return _apiResponseParser.handleResponse(result);
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
    return _apiResponseParser.handleResponse(result);
  }

  Future<ResultEntity> put({
    required String endpoint,
    required Map<String, dynamic> body,
    bool isformData = false,
  }) async {
    final token = await _authService.getJwt();
    final result = await _clientRequest.put(
      path: '$_host/$endpoint',
      headers: getHeaders(token),
      body: body,
      isformData: isformData,
    );
    return _apiResponseParser.handleResponse(result);
  }
}
