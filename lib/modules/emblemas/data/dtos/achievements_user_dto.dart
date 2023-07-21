import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class AchievementsUserDto {
  final String? uid;
  final String idemblema;
  final int timecria;
  final String userid;
  final int? createdat;
  final int? updatedat;

  AchievementsUserDto(
    this.uid,
    this.idemblema,
    this.timecria,
    this.userid,
    this.createdat,
    this.updatedat,
  );

  factory AchievementsUserDto.fromEntity(EmblemaUser entity) {
    return AchievementsUserDto(
      entity.id,
      entity.idEmblema,
      entity.timeCria,
      entity.userId,
      entity.createAt,
      entity.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'idemblema': idemblema,
      'timecria': timecria,
      'userid': userid,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory AchievementsUserDto.fromMap(Map<String, dynamic> map) {
    return AchievementsUserDto(
      map['uid'],
      map['idemblema'],
      map['timecria'],
      map['userid'],
      map['createdat'] ?? map['timecria'],
      map['updatedat'] ?? map['timecria'],
    );
  }
  EmblemaUser toEntity() {
    return EmblemaUser(
      id: uid,
      timeCria: timecria,
      userId: userid,
      idEmblema: idemblema,
      createAt: createdat ?? timecria,
      updateAt: createdat ?? timecria,
    );
  }
}
