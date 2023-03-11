import 'package:dashboard_manga_easy/modules/mangas/data/datasources/manga_datasource.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/mappers/mapper_manga.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class MangaRepositoryImp implements MangaRepository {
  final MangaDatasource _mangaDatasource;
  final MangaMapper _mangaMapper;
  MangaRepositoryImp(this._mangaDatasource, this._mangaMapper);

  @override
  Future<List<InfoComicModel>> getManga({
    required MangaFilterEntity filter,
    int? limit,
    int? offset,
  }) async {
    var result = await _mangaDatasource.list(
      filter: filter,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );
    return result.data.map((e) => _mangaMapper.from(e)).toList();
  }

  @override
  Future<List<String>> getGenders(List<String> genders) async {
    return genders;
  }

  @override
  Future<void> updateManga({required InfoComicModel manga}) async {
    await _mangaDatasource.updateManga(manga: manga);
  }
}
