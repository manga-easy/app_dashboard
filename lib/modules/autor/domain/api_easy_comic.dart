import 'dart:convert';

import 'package:dio/dio.dart';

class ApiEasyComicAuthorial {
  final String urlBase = 'http://localhost:8083/';
  final client = Dio();

  Future get(String path) async {
    var ret = await client.get(urlBase + path);
    return json.decode(ret.data);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    var ret = await client.post(urlBase + path, data: body);
    return json.decode(ret.data);
  }

  Future<Map<String, dynamic>> put(String path, Map<String, dynamic> body) async {
    var ret = await client.put(urlBase + path, data: body);
    return json.decode(ret.data);
  }

  Future<Map<String, dynamic>> delete(String path, Map<String, dynamic> body) async {
    var ret = await client.delete(urlBase + path, data: body);
    return json.decode(ret.data);
  }
}
