import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class GetConfigAppCase {
  final IConfigAppRepository configAppRepository;

  GetConfigAppCase(this.configAppRepository);

  Future<ConfigAppModel> call() async {
    return await configAppRepository.getConfig();
  }
}
