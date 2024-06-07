import 'package:dashboard_manga_easy/core/services/api_monolito/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/info_comic_model.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/mappers/mapper_manga.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';

class MangaRepositoryImp implements MangaRepository {
  final ApiMonolith _apiMonolito;
  final MangaMapper _mangaMapper;
  MangaRepositoryImp(this._apiMonolito, this._mangaMapper);

  final String path = 'catalog';
  final String url = 'http://test-catalog.lucas-cm.com.br';
  final String version = 'v1';

  @override
  Future<void> updateManga({required InfoComicModel manga}) async {
    await _apiMonolito.put(
      '$url/$version/$path',
      body: _mangaMapper.toJson(manga),
    );
  }

  @override
  Future<List<InfoComicModel>> getManga({
    required MangaFilterEntity filter,
    int? limit,
    int? offset,
  }) async {
    var params = '';
    if (filter.search != null) {
      params += 'search=${filter.search}&';
    }
    if (filter.genders.isNotEmpty) {
      params += 'genders=${filter.genders.join('<>')}&';
    }

    if (filter.yearAt != null && filter.yearFrom != null) {
      params += 'yearFrom=${filter.yearFrom}&';
      params += 'yearAt=${filter.yearAt}&';
    }

    if (filter.author != null) {
      params += 'author=${filter.author}&';
    }
    if (filter.uniqueid != null) {
      params += 'uniqueid=${filter.uniqueid}&';
    }
    final result = await _apiMonolito.get(
      '$url/$version/$path?limit=$limit&offset=$offset&$params',
    );
    return (result['data'] as List)
        .map<InfoComicModel>((e) => _mangaMapper.from(e.toJson()))
        .toList();
  }
}
