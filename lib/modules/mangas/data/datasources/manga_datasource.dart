import 'package:dashboard_manga_easy/modules/mangas/data/dtos/manga_dto.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class MangaDatasource {
  Future<MangaDto> list({
    required MangaFilterEntity filter,
    int? offset,
    int? limit,
  });
  Future<void> updateManga({required InfoComicModel manga});
}
