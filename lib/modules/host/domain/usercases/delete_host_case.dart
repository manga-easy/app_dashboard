import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class DeleteHostCase {
  final HostRepository hostRepository;
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;

  DeleteHostCase(
    this.hostRepository,
    this.getConfigAppCase,
    this.upConfigAppCase,
  );

  Future<void> call(HostModel host) async {
    await hostRepository.deletDocument(id: host.id!);
    updateConfigApp();
  }

  Future<void> updateConfigApp() async {
    var ret = await getConfigAppCase();
    await upConfigAppCase(ret);
  }
}
