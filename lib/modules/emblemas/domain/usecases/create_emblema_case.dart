import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class CreateEmblemaCase {
  final EmblemasRepository _emblemasRepository;
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;

  CreateEmblemaCase(
    this._emblemasRepository,
    this.getConfigAppCase,
    this.upConfigAppCase,
  );

  Future<void> call({required Emblema emblema});
}

class CreateEmblemaCaseImpl extends CreateEmblemaCase {
  CreateEmblemaCaseImpl(
    super.emblemasRepository,
    super.getConfigAppCase,
    super.upConfigAppCase,
  );

  @override
  Future<void> call({required Emblema emblema}) async {
    await _emblemasRepository.creatDocument(
      objeto: emblema,
    );
    updateConfigApp();
  }

  Future<void> updateConfigApp() async {
    var ret = await getConfigAppCase();
    await upConfigAppCase(ret);
  }
}
