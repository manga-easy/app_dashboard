import 'package:manga_easy_sdk/manga_easy_sdk.dart';

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

  factory RecommendationsDto.fromEntity(RecomendacoesModel entity) {
    return RecommendationsDto(
      uid: entity.id,
      uniqueid: entity.uniqueid,
      title: entity.title,
      link: entity.link,
      datacria: entity.dataCria,
      createdat: entity.createdAt,
      updatedat: entity.updatedAt,
      artistid: entity.artistId,
      artistname: entity.artistName,
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
      'artistid': artistid,
      'artistname': artistname,
    };
  }

  factory RecommendationsDto.fromMap(Map<String, dynamic> map) {
    return RecommendationsDto(
      uid: map['uid'],
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

  RecomendacoesModel toEntity() {
    return RecomendacoesModel(
      id: uid,
      title: title,
      link: link,
      uniqueid: uniqueid,
      dataCria: datacria,
      createdAt: createdat ?? datacria,
      updatedAt: createdat ?? datacria,
      artistId: artistid,
      artistName: artistname,
    );
  }
}
