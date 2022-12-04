import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class UpBlockListCase {
  final IConfigAppRepository configAppRepository;

  UpBlockListCase(this.configAppRepository);

  Future<void> call(BlockListModel blockList) async {
    await configAppRepository.updateBlockList(blockList);
  }
}
