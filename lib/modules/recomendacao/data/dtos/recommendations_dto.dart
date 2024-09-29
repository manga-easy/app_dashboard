import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';

class RecommendationsDto {
  final String? uid;
  final String uniqueid;
  final String title;
  final String link;
  final int datacria;
  final int? createdat;
  final int? updatedat;
  final String? artistid;
  final String? artistname;

  RecommendationsDto({
    this.uid,
    required this.uniqueid,
    required this.title,
    required this.link,
    required this.datacria,
    required this.createdat,
    required this.updatedat,
    required this.artistid,
    required this.artistname,
  });

  factory RecommendationsDto.fromEntity(RecommendationsEntity entity) {
    return RecommendationsDto(
      uid: entity.id,
      uniqueid: entity.uniqueid,
      title: entity.title,
      link: entity.link,
      datacria: entity.createdAt,
      createdat: entity.createdAt,
      updatedat: entity.updatedAt,
      artistid: entity.artistId,
      artistname: entity.artistName,
    );
  }

  factory RecommendationsDto.fromMap(Map<String, dynamic> map) {
    return RecommendationsDto(
      uid: map['id'],
      uniqueid: map['uniqueid'],
      title: map['title'],
      link: map['link'],
      datacria: map['datacria'] ?? 0,
      createdat: map['createdat'],
      updatedat: map['updatedat'],
      artistid: map['artistid'],
      artistname: map['artistname'],
    );
  }

  RecommendationsEntity toEntity() {
    return RecommendationsEntity(
      id: uid,
      title: title,
      link: link,
      uniqueid: uniqueid,
      createdAt: createdat ?? datacria,
      updatedAt: createdat ?? datacria,
      artistId: artistid,
      artistName: artistname,
    );
  }
}
