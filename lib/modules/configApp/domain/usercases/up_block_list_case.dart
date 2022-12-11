import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UpBlockListCase {
  final IConfigAppRepository configAppRepository;

  UpBlockListCase(this.configAppRepository);

  Future<void> call(BlockListModel blockList) async {
    await configAppRepository.updateBlockList(blockList);
  }
}
