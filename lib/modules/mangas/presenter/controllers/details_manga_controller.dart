import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/info_comic_model.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/entities/manga_filter_entity.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/manga_repository.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class DetailsMangaController extends ManagerStore {
  final MangaRepository mangaRepository;

  DetailsMangaController(this.mangaRepository);
  String? uniqueid;
  InfoComicModel? manga;

  @override
  void init(Map<String, dynamic> arguments) {
    uniqueid = Helps.convertUniqueid(arguments['nameManga']!);
    loadingManga();
  }

  Future<void> loadingManga() async {
    try {
      state = StateManager.loading;
      final result = await mangaRepository.getManga(
        filter: MangaFilterEntity(
          uniqueid: uniqueid,
          genders: [],
        ),
      );
      manga = result.first;
    } catch (e) {
      Helps.log(e);
      state = StateManager.error;
    }
    state = StateManager.done;
  }

  Future<void> updateManga() async {
    try {
      state = StateManager.loading;
      await mangaRepository.updateManga(manga: manga!);
    } catch (e) {
      Helps.log(e);
    }
    state = StateManager.done;
  }
}
