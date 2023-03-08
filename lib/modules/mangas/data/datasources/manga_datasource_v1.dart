import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/datasources/manga_datasource.dart';
import 'package:dashboard_manga_easy/modules/mangas/data/dtos/manga_dto.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:manga_easy_sdk/src/modules/manga/info_comic_model.dart';

class MangaDatasourceV1 extends MangaDatasource {
  final DriverHttp _clientDriver;
  final String path = 'catalog';
  final String url = 'http://test-catalog.lucas-cm.com.br';
  final String version = 'v1';

  MangaDatasourceV1(this._clientDriver);
  @override
  Future<MangaDto> list({
    required MangaFilterEntity filter,
    int? offset,
    int? limit,
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
    var result = await _clientDriver.get(
      path: '$url/$version/$path?limit=$limit&offset=$offset&$params',
    );
    return MangaDto.fromJson(result.data);
  }

  @override
  Future<void> updateManga({required InfoComicModel manga}) async {
    await _clientDriver.put(
      path: '$url/$version/$path',
      body: manga.toJson(),
    );
  }
}
