import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';

class CreateRecommendationsDto {
  final String uniqueId;
  final String title;
  final String artistId;

  CreateRecommendationsDto({
    required this.uniqueId,
    required this.title,
    required this.artistId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uniqueId': uniqueId,
      'title': title,
      'artistId': artistId,
    };
  }

  factory CreateRecommendationsDto.fromEntity(RecommendationsEntity entity) {
    return CreateRecommendationsDto(
      artistId: entity.artistId ?? '',
      title: entity.title,
      uniqueId: entity.uniqueid,
    );
  }

  factory CreateRecommendationsDto.empty() {
    return CreateRecommendationsDto(
      artistId: '',
      title: '',
      uniqueId: '',
    );
  }

  CreateRecommendationsDto copyWith({
    String? uniqueId,
    String? title,
    String? artistId,
  }) {
    return CreateRecommendationsDto(
      uniqueId: uniqueId ?? this.uniqueId,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
    );
  }
}
