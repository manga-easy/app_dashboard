import 'dart:convert';

import 'package:http/http.dart';

class ApiEasyComicAuthorial {
  final String urlBase = 'http://localhost:8083/';
  final client = Client();

  Future get(String path) async {
    var ret = await client.get(Uri.parse(urlBase + path));
    return json.decode(ret.body);
  }

  Future<Map<String, dynamic>?> post(String path, Map<String, dynamic> body) async {
    var ret = await client.post(Uri.parse(urlBase + path), body: body);
    return json.decode(ret.body);
  }

  Future<Map<String, dynamic>?> put(String path, Map<String, dynamic> body) async {
    var ret = await client.put(Uri.parse(urlBase + path), body: body);
    return json.decode(ret.body);
  }

  Future<Map<String, dynamic>?> delete(String path, Map<String, dynamic> body) async {
    var ret = await client.delete(Uri.parse(urlBase + path), body: body);
    return json.decode(ret.body);
  }
}
