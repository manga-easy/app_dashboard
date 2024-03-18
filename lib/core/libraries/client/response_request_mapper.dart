import 'dart:convert';
import 'package:dashboard_manga_easy/core/libraries/client/response_request_entity.dart';
import 'package:dio/dio.dart' as dio;

class ResponseRequestMapper {
  ResponseRequestEntity fromDio(dio.Response response) {
    return ResponseRequestEntity(
      data: _convertToMap(response.data),
      statusCode: response.statusCode ?? 0,
      statusMessage: response.statusMessage ?? '',
    );
  }

  Map<String, dynamic> _convertToMap(body) {
    if (body.isEmpty) {
      return {};
    }
    if (body is List<int>) {
      //Bovino penso que era assim
      final result = json.decode(utf8.decode(body));
      if (result is List) {
        return {'data': result};
      }
      return result;
    }

    if (body is List || body is String) {
      return {'data': body};
    }

    return body;
  }
}
