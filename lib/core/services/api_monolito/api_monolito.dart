import 'package:client_driver/client_driver.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:manga_easy_sdk/src/services/api_response_parse/result_entity.dart';

class ApiMonolito {
  final ApiResponseParser _apiResponseParser;
  final ClientRequest _clientRequest;
  final String _host = 'http://192.168.15.8:8080';

  ApiMonolito(this._clientRequest, this._apiResponseParser);
  Map<String, dynamic> get headers {
    return {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI2MjI4YmZmYWI4NDJiYjg2YThlNCJ9.jwJZXw5j5Bb_CNoqgcLfPH-WM9l1XG4aRzG4KmKxDA4',
    };
  }

  Future<ResultEntity> get({required String endpoint}) async {
    final result = await _clientRequest.get(
      path: '$_host/$endpoint',
      headers: headers,
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }

  Future<ResultEntity> delete({required String endpoint}) async {
    final result = await _clientRequest.delete(
      path: '$_host/$endpoint',
      headers: headers,
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
    final result = await _clientRequest.post(
      path: '$_host/$endpoint',
      headers: headers,
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
    final result = await _clientRequest.put(
      path: '$_host/$endpoint',
      headers: headers,
      body: body,
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }
}
