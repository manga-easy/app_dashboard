import 'package:dashboard_manga_easy/core/libraries/client/client_dio.dart';
import 'package:dashboard_manga_easy/core/libraries/client/cliente_request.dart';
import 'package:dashboard_manga_easy/core/services/api_monolito/api_response_parse/api_response_parse.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiMonolith {
  final ApiResponseParser _apiResponseParser = ApiResponseParser();
  final ClientRequest _clientRequest = ClientDio();
  final AuthService _authService;
  final String _host = kDebugMode
      ? 'https://test.lucas-cm.com.br'
      : 'https://monolito.lucas-cm.com.br';
  String? get jwt => ServiceRoute.token;
  set jwt(v) => ServiceRoute.token = v;

  ApiMonolith(this._authService);

  Future<Map<String, dynamic>> _getHeaders({required bool isToken}) async {
    final Map<String, dynamic> headers = {};
    if (isToken) {
      if (_isExpiredJWT()) {
        jwt = await _authService.getJwt();
      }
      headers['Authorization'] = 'Bearer $jwt';
    }
    headers['me-app-version'] = '0.99.0';
    return headers;
  }

  bool _isExpiredJWT() {
    if (jwt == null) {
      return true;
    }
    return JwtDecoder.isExpired(jwt!);
  }

  Future<dynamic> get(
    String path, {
    bool isToken = true,
  }) async {
    final result = await _clientRequest.get(
      path: '$_host/$path',
      headers: await _getHeaders(isToken: isToken),
    );
    return _apiResponseParser.handleResponse(result);
  }

  Future<dynamic> delete(
    String path, {
    bool isToken = true,
  }) async {
    final result = await _clientRequest.delete(
      path: '$_host/$path',
      headers: await _getHeaders(isToken: isToken),
    );
    return _apiResponseParser.handleResponse(result);
  }

  Future<dynamic> post(
    String path, {
    required Map<String, dynamic> body,
    bool isToken = true,
  }) async {
    final result = await _clientRequest.post(
      path: '$_host/$path',
      headers: await _getHeaders(isToken: isToken),
      body: body,
    );
    return _apiResponseParser.handleResponse(result);
  }

  Future<dynamic> put(
    String path, {
    required Map<String, dynamic> body,
    bool isToken = true,
    bool isformData = false,
  }) async {
    final result = await _clientRequest.put(
      path: '$_host/$path',
      headers: await _getHeaders(isToken: isToken),
      body: body,
      isformData: isformData,
    );
    return _apiResponseParser.handleResponse(result);
  }
}
