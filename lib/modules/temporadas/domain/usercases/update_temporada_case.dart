import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/get_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/usercases/up_config_app_case.dart';
import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class UpdateTemporadaCase {
  final GetConfigAppCase getConfigAppCase;
  final UpConfigAppCase upConfigAppCase;
  final TemporadasRepository _temporadasRepository;

  UpdateTemporadaCase(
    this._temporadasRepository,
    this.getConfigAppCase,
    this.upConfigAppCase,
  );

  Future<void> call({required TemporadaModel temporada});
}

class UpdateTemporadaCaseImpl extends UpdateTemporadaCase {
  UpdateTemporadaCaseImpl(
    super.temporadasRepository,
    super.getConfigAppCase,
    super.upConfigAppCase,
  );

  @override
  Future<void> call({required TemporadaModel temporada}) async {
    await _temporadasRepository.creatDocument(objeto: temporada);
    updateConfigApp();
  }

  Future<void> updateConfigApp() async {
    var ret = await getConfigAppCase();
    await upConfigAppCase(ret);
  }
}
