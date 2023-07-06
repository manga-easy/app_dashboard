import 'package:client_driver/client_driver.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:manga_easy_sdk/src/services/api_response_parse/result_entity.dart';

class ApiMonolito {
  final ApiResponseParser _apiResponseParser;
  final ClientRequest _clientRequest;
  final String _host = 'https://monolito.lucas-cm.com.br/';

  ApiMonolito(this._clientRequest, this._apiResponseParser);

  Future<ResultEntity> get({required String endpoint}) async {
    final result = await _clientRequest.get(
      path: '$_host/$endpoint',
      headers: {},
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }

  Future<ResultEntity> delete({required String endpoint}) async {
    final result = await _clientRequest.delete(
      path: '$_host/$endpoint',
      headers: {},
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
      headers: {},
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
      headers: {},
      body: body,
    );
    return _apiResponseParser.handleResponse(
      statusCode: result.statusCode,
      response: result.data,
    );
  }
}
