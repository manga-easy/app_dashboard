import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CreateHostCase {
  final HostRepository hostRepository;
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;

  CreateHostCase(
    this.hostRepository,
    this.getConfigAppCase,
    this.upConfigAppCase,
  );

  Future<void> call(HostModel host) async {
    if (host.name.isEmpty) {
      throw Exception('Nome não pode ser vazio');
    }
    if (host.host.isEmpty) {
      throw Exception('Url não pode ser vazio');
    }
    if (host.interstitialAdUnitId.isEmpty) {
      throw Exception('interstitialAdUnitId não pode ser vazio');
    }
    var ret = await hostRepository.listDocument();

    host.order = ++ret.first.order;
    host.idHost = ++ret.first.idHost;

    await hostRepository.creatDocument(objeto: host);
    updateConfigApp();
  }

  Future<void> updateConfigApp() async {
    var ret = await getConfigAppCase();
    await upConfigAppCase(ret);
  }
}
