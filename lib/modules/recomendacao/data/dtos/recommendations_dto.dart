import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class RecommendationsDto {
  final String? uid;
  final String uniqueid;
  final String title;
  final String link;
  final int datacria;
  final int? createdat;
  final int? updatedat;

  RecommendationsDto({
    this.uid,
    required this.uniqueid,
    required this.title,
    required this.link,
    required this.datacria,
    required this.createdat,
    required this.updatedat,
  });

  factory RecommendationsDto.fromEntity(RecomendacoesModel entity) {
    return RecommendationsDto(
      uid: entity.id,
      uniqueid: entity.uniqueid,
      title: entity.title,
      link: entity.link,
      datacria: entity.dataCria,
      createdat: entity.createdAt,
      updatedat: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'uniqueid': uniqueid,
      'title': title,
      'link': link,
      'datacria': datacria,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory RecommendationsDto.fromMap(Map<String, dynamic> map) {
    return RecommendationsDto(
      uid: map['uid'],
      uniqueid: map['uniqueid'],
      title: map['title'],
      link: map['link'],
      datacria: map['datacria'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }

  RecomendacoesModel toEntity() {
    return RecomendacoesModel(
      title: title,
      link: link,
      uniqueid: uniqueid,
      dataCria: datacria,
      createdAt: createdat ?? datacria,
      updatedAt: createdat ?? datacria,
    );
  }
}
