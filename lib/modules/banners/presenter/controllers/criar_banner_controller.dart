import 'package:dashboard_manga_easy/modules/banners/data/dtos/create_banner_dto.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';
import 'package:dashboard_manga_easy/modules/banners/presenter/ui/events/details_banner_event.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class CriarBannerController extends ManagerStore<DetailsBannerEvent> {
  final BannerRepositoryV2 bannerRepository;
  BannerEntity? banner;
  CreateBannerDto dto = CreateBannerDto.empty();

  CriarBannerController({required this.bannerRepository});

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    final String? id = arguments['id'];
    if (id != 'null') {
      final banners = await bannerRepository.listDocument();
      banner = banners.firstWhere((element) => element.id == id);
      dto = CreateBannerDto.fromEntity(banner!);
    }
    state = StateManager.done;
  }

  void criarBanner() => handleTry(
        call: () async {
          String tipo = 'criado';
          if (banner == null) {
            await bannerRepository.creatDocument(dto: dto);
          } else {
            await bannerRepository.updateDocument(dto: dto, id: banner!.id);
            tipo = 'salvo';
          }
          emitNavigation(DetailsBannerEventSuccess(tipo));
        },
      );
}
