import 'package:dashboard_manga_easy/modules/temporadas/domain/repositories/temporadas_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class ListTemporadaCase {
  final TemporadasRepository _temporadasRepository;

  ListTemporadaCase(this._temporadasRepository);

  Future<List<TemporadaModel>> call();
}

class ListTemporadaCaseImpl extends ListTemporadaCase {
  ListTemporadaCaseImpl(super.temporadasRepository);

  @override
  Future<List<TemporadaModel>> call() async {
    var ret = await _temporadasRepository.listDocument();
    return ret.data;
  }
}
