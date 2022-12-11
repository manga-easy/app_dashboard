import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UpConfigAppCase {
  final IConfigAppRepository configAppRepository;

  UpConfigAppCase(this.configAppRepository);

  Future<void> call(ConfigAppModel config) async {
    config.updateApp = DateTime.now().millisecondsSinceEpoch;
    if (config.hostAppwrite.isEmpty) {
      Exception('Host appwrite não pode ser vazio');
    }
    await configAppRepository.updateConfig(config);
  }
}
