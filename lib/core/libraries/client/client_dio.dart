import 'dart:convert';
import 'package:dashboard_manga_easy/core/libraries/client/cliente_request.dart';
import 'package:dashboard_manga_easy/core/libraries/client/response_request_entity.dart';
import 'package:dashboard_manga_easy/core/libraries/client/response_request_mapper.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dio/dio.dart';

class ClientDio extends ClientRequest {
  final ResponseRequestMapper _responseRequestMapper = ResponseRequestMapper();
  final Dio _dio = Dio();

  ClientDio();

  @override
  Future<ResponseRequestEntity> get({
    required String path,
    Map<String, dynamic>? headers,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) async {
    try {
      _log(method: 'get', path: path, headers: headers);
      final result = await _dio.get(
        path,
        options: Options(
          headers: headers,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );

      return _responseRequestMapper.fromDio(result);
    } on DioException catch (e) {
      final data = e.response?.data ?? {};
      return ResponseRequestEntity(
        data: data is Map<String, dynamic> ? data : {},
        statusCode: e.response?.statusCode ?? 0,
        statusMessage:
            e.response?.statusMessage ?? e.message ?? e.error.toString(),
      );
    }
  }

  @override
  Future<ResponseRequestEntity> put({
    required String path,
    required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool isformData = false,
  }) async {
    try {
      dynamic data = body;
      if (isformData) {
        _log(method: 'put', path: path, headers: headers);
        data = FormData.fromMap(body!);
      } else {
        _log(method: 'put', path: path, headers: headers, body: body);
      }
      final result = await _dio.put(
        path,
        data: data,
        options: Options(
          headers: headers,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );
      return _responseRequestMapper.fromDio(result);
    } on DioException catch (e) {
      final data = e.response?.data ?? {};
      return ResponseRequestEntity(
        data: data is Map<String, dynamic> ? data : {},
        statusCode: e.response?.statusCode ?? 0,
        statusMessage:
            e.response?.statusMessage ?? e.message ?? e.error.toString(),
      );
    }
  }

  @override
  Future<ResponseRequestEntity> post({
    required String path,
    required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) async {
    try {
      _log(method: 'post', path: path, headers: headers, body: body);
      final result = await _dio.post(
        path,
        data: body,
        options: Options(
          headers: headers,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );

      return _responseRequestMapper.fromDio(result);
    } on DioException catch (e) {
      final data = e.response?.data ?? {};
      return ResponseRequestEntity(
        data: data is Map<String, dynamic> ? data : {},
        statusCode: e.response?.statusCode ?? 0,
        statusMessage:
            e.response?.statusMessage ?? e.message ?? e.error.toString(),
      );
    }
  }

  @override
  Future<ResponseRequestEntity> delete({
    required String path,
    Map<String, dynamic>? headers,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) async {
    try {
      _log(method: 'delete', path: path, headers: headers);
      final result = await _dio.delete(
        path,
        options: Options(
          headers: headers,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );

      return _responseRequestMapper.fromDio(result);
    } on DioException catch (e) {
      final data = e.response?.data ?? {};
      return ResponseRequestEntity(
        data: data is Map<String, dynamic> ? data : {},
        statusCode: e.response?.statusCode ?? 0,
        statusMessage:
            e.response?.statusMessage ?? e.message ?? e.error.toString(),
      );
    }
  }

  void _log({
    required String method,
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) {
    Helps.log(
      '=============================== INICIO ==============================\n'
      '=============== Method: $method \n'
      '=============== Path: $path \n'
      '=============== Body: ${json.encode(body)} \n'
      '=============== Headers: ${json.encode(headers)} \n'
      '============================= FIM ================================\n',
    );
  }
}
