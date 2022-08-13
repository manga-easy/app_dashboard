import 'package:dashboard_manga_easy/modules/autor/domain/api_easy_comic.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_model.dart';
import 'package:flutter/foundation.dart';

class ComicAuthorialRepository {
  final ApiEasyComicAuthorial apiEasyComicAuthorial = ApiEasyComicAuthorial();

  Future<void> create({required ComicAuthorialModel objeto}) async {
    await apiEasyComicAuthorial.post('comic', objeto.toJson());
  }

  Future<void> delete({required String id}) {
    // TODO: implement deletDocument
    throw UnimplementedError();
  }

  Future<ComicAuthorialModel?> get({required String id}) async {
    try {
      var ret = await apiEasyComicAuthorial.get('comic/$id');
      return ComicAuthorialModel.fromJson(ret);
    } catch (e) {
      return null;
    }
  }

  Future<List<ComicAuthorialModel>> list({String? where}) async {
    try {
      var ret = await apiEasyComicAuthorial.get('comic');
      if (ret is List) {
        return compute(_parseComicAuthorial, ret);
      }
      print(ret.runtimeType);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> update({required ComicAuthorialModel objeto}) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  static List<ComicAuthorialModel> _parseComicAuthorial(dynamic map) {
    return map.map<ComicAuthorialModel>((e) => ComicAuthorialModel.fromJson(e)).toList();
  }
}
