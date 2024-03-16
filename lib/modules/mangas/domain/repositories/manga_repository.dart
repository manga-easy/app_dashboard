import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/info_comic_model.dart';

abstract class MangaRepository {
  Future<List<InfoComicModel>> getManga({
    required MangaFilterEntity filter,
    int? limit,
    int? offset,
  });
  Future<List<String>> getGenders(List<String> genders);

  Future<void> updateManga({required InfoComicModel manga});
}
