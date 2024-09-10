import 'package:dashboard_manga_easy/core/libraries/client/client_dio.dart';
import 'package:dashboard_manga_easy/core/libraries/client/cliente_request.dart';
import 'package:dashboard_manga_easy/core/services/apis/api_response_parse/api_response_parse.dart';
import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiToggle {
  final ApiResponseParser _apiResponseParser = ApiResponseParser();
  final ClientRequest _clientRequest = ClientDio();
  final AuthService _authService;
  final String _host =
      const String.fromEnvironment('ENVIRONMENT', defaultValue: 'test') ==
              'production'
          ? 'https://micro-config.lucas-cm.com.br'
          : 'https://toggle-test.lucas-cm.com.br';
  String version = 'v1/toggle';
  String? get jwt => ServiceRoute.token;
  set jwt(v) => ServiceRoute.token = v;

  ApiToggle(this._authService);

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
      path: '$_host/$version/$path',
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
      path: '$_host/$version/$path',
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
      path: '$_host/$version/$path',
      headers: await _getHeaders(isToken: isToken),
      body: body,
      isformData: isformData,
    );
    return _apiResponseParser.handleResponse(result);
  }
}
