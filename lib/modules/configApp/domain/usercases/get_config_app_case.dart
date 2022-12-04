import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class GetConfigAppCase {
  final IConfigAppRepository configAppRepository;

  GetConfigAppCase(this.configAppRepository);

  Future<ConfigAppModel> call() async {
    return await configAppRepository.getConfig();
  }
}
