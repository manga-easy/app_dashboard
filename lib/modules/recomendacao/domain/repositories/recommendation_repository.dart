import 'dart:io';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';

abstract interface class RecommendationsRepository {
  Future<RecomendacoesModel?> getDocument({required String id});

  Future<void> updateDocument({required RecomendacoesModel objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required RecomendacoesModel objeto});

  Future<List<RecomendacoesModel>> listDocument({
    RecommendationsFilter? filter,
  });

  Future<void> updateImage({required File file, required String uniqueid});
}
