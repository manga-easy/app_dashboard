import 'dart:io';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';

abstract interface class RecommendationsRepository {
  Future<RecommendationsEntity?> getDocument({required String id});

  Future<void> updateDocument({required RecommendationsEntity objeto});

  Future<void> deletDocument({required String id});

  Future<void> creatDocument({required RecommendationsEntity objeto});

  Future<List<RecommendationsEntity>> listDocument({
    RecommendationsFilter? filter,
  });

  Future<void> updateImage({required File file, required String id});
}
