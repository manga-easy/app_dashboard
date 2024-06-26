import 'package:dashboard_manga_easy/modules/mangas/domain/entities/info_comic_model.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';

abstract class MangaRepository {
  Future<List<InfoComicModel>> getManga({
    required MangaFilterEntity filter,
    int? limit,
    int? offset,
  });

  Future<void> updateManga({required InfoComicModel manga});
}
