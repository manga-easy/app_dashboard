import 'package:dashboard_manga_easy/modules/autor/domain/api_easy_comic.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:flutter/foundation.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class ComicAuthorialRepository {
  final ApiEasyComicAuthorial apiEasyComicAuthorial = ApiEasyComicAuthorial();

  Future<void> create({required ComicAuthorialModel objeto}) async {
    var ret = await apiEasyComicAuthorial.post('comic', objeto.toJson());
    if (ret.containsKey('erro')) {
      throw Exception(ret['erro']);
    }
  }

  Future<void> delete({required String id}) {
    // TODO: implement deletDocument
    throw UnimplementedError();
  }

  Future<ComicAuthorialModel?> get({required int id}) async {
    try {
      var ret = await apiEasyComicAuthorial.get('comic/$id');
      return ComicAuthorialModel.fromJson(ret);
    } catch (e) {
      Helps.log(e);
      return null;
    }
  }

  Future<List<ComicAuthorialModel>> list({String? where}) async {
    try {
      var ret = await apiEasyComicAuthorial.get('comic');
      if (ret is List) {
        return compute(_parseComicAuthorial, ret);
      }
      return [];
    } catch (e) {
      Helps.log(e);
      return [];
    }
  }

  Future<void> update({required ComicAuthorialModel objeto}) async {
    var ret = await apiEasyComicAuthorial.put('comic', objeto.toJson());
    if (ret.containsKey('erro')) {
      throw Exception(ret['erro']);
    }
  }

  static List<ComicAuthorialModel> _parseComicAuthorial(dynamic map) {
    return map
        .map<ComicAuthorialModel>((e) => ComicAuthorialModel.fromJson(e))
        .toList();
  }
}
