import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/banners/data/repositories/banner_repository.dart';
import 'package:dashboard_manga_easy/modules/banners/domain/entities/banner_entity.dart';
import 'package:page_manager/manager_store.dart';

class BannerController extends ManagerStore<bool> {
  final BannerRepositoryV2 bannerRepository;
  var listaBannerItens = <BannerEntity>[];
  BannerController({required this.bannerRepository});

  @override
  void init(Map<String, dynamic> arguments) {
    listaBanner();
  }

  Future<void> listaBanner() => handleTry(
        call: () async =>
            listaBannerItens = await bannerRepository.listDocument(),
        onWhenRethow: (e) => false,
      );

  Future<void> deleteBanner(String id, context) => handleTry(
      call: () async {
        await bannerRepository.deletDocument(id: id);
        AppHelps.confirmaDialog(
          title: 'Sucesso',
          content: 'Banner deletada com sucesso',
          context: context,
        );
      },
      onWhenRethow: (e) => false);
}
