import 'package:dashboard_manga_easy/modules/autor/domain/api_easy_comic.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_model.dart';
import 'package:flutter/foundation.dart';

class ComicRepository {
  final ApiEasyComic apiEasyComic = ApiEasyComic();

  Future<void> create({required ComicModel objeto}) async {
    await apiEasyComic.post('comic', objeto.toJson());
  }

  Future<void> delete({required String id}) {
    // TODO: implement deletDocument
    throw UnimplementedError();
  }

  Future<ComicModel?> get({required String id}) async {
    try {
      var ret = await apiEasyComic.get('comic/$id');
      return ComicModel.fromJson(ret);
    } catch (e) {
      return null;
    }
  }

  Future<List<ComicModel>> list({String? where}) async {
    try {
      var ret = await apiEasyComic.get('comic');
      if (ret is List) {
        return compute(_parseComic, ret);
      }
      print(ret.runtimeType);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> update({required ComicModel objeto}) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  static List<ComicModel> _parseComic(dynamic map) {
    return map.map<ComicModel>((e) => ComicModel.fromJson(e)).toList();
  }
}
