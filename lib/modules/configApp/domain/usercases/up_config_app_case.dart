import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

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
