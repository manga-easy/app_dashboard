import 'package:dashboard_manga_easy/core/interfaces/external_repositories_interface.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/api_easy_comic.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/comic_model.dart';

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
      return ComicModel.fromJson(ret!);
    } catch (e) {
      return null;
    }
  }

  Future<List<ComicModel>> list({String? where}) async {
    try {
      var ret = await apiEasyComic.get('comic');
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> update({required ComicModel objeto}) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }
}
