import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class GetBlockListCase {
  final IConfigAppRepository configAppRepository;

  GetBlockListCase(this.configAppRepository);

  Future<BlockListModel> call() async {
    return await configAppRepository.getBlockList();
  }
}
