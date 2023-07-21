import 'package:dashboard_manga_easy/modules/temporadas/domain/models/temporadas_params.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract interface class SeasonsRepository {
  Future<void> creatDocument({required TemporadaModel objeto});

  Future<TemporadaModel?> getDocument({required String id});

  Future<void> updateDocument({required TemporadaModel objeto});

  Future<List<TemporadaModel>> listDocument({TemporadasParams? where});
}
