import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema_params.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class ListEmblemasCase {
  final EmblemasRepository _emblemasRepository;

  ListEmblemasCase(this._emblemasRepository);

  Future<List<Emblema>> call({required EmblemaParams where});
}

class ListEmblemasCaseImpl extends ListEmblemasCase {
  ListEmblemasCaseImpl(super.emblemasRepository);

  @override
  Future<List<Emblema>> call({required EmblemaParams where}) async {
    var ret = await _emblemasRepository.listDocument(where: where);
    return ret.data;
  }
}
