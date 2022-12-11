import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class UpBlockListCase {
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;
  final IConfigAppRepository configAppRepository;

  UpBlockListCase(
    this.configAppRepository,
    this.getConfigAppCase,
    this.upConfigAppCase,
  );

  Future<void> call(BlockListModel blockList);
}

class UpBlockListCaseImpl extends UpBlockListCase {
  UpBlockListCaseImpl(
    super.configAppRepository,
    super.getConfigAppCase,
    super.upConfigAppCase,
  );

  @override
  Future<void> call(BlockListModel blockList) async {
    await configAppRepository.updateBlockList(blockList);
    updateConfigApp();
  }

  Future<void> updateConfigApp() async {
    var ret = await getConfigAppCase();
    await upConfigAppCase(ret);
  }
}
