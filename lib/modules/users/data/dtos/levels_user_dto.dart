import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class LevelsUserDto {
  final String? uid;
  final String name;
  final int total;
  final String temporada;
  final int lvl;
  final int timecria;
  final int quantity;
  final int minute;
  final String userid;
  final int timeup;
  final int? createdat;
  final int? updatedat;
  LevelsUserDto({
    this.uid,
    required this.name,
    required this.total,
    required this.temporada,
    required this.lvl,
    required this.timecria,
    required this.quantity,
    required this.minute,
    required this.userid,
    required this.timeup,
    required this.createdat,
    required this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'total': total,
      'temporada': temporada,
      'lvl': lvl,
      'timecria': timecria,
      'quantity': quantity,
      'minute': minute,
      'userid': userid,
      'timeup': timeup,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory LevelsUserDto.fromMap(Map<String, dynamic> map) {
    return LevelsUserDto(
      uid: map['uid'],
      name: map['name'],
      total: map['total'],
      temporada: map['temporada'],
      lvl: map['lvl'],
      timecria: map['timecria'],
      quantity: map['quantity'],
      minute: map['minute'],
      userid: map['userid'],
      timeup: map['timeup'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }
  factory LevelsUserDto.fromEntity(NivelUser entity) {
    return LevelsUserDto(
      uid: entity.id,
      name: entity.name,
      total: entity.total,
      temporada: entity.temporada,
      lvl: entity.lvl,
      timecria: entity.timeCria,
      quantity: entity.quantity,
      minute: entity.minute,
      userid: entity.userId,
      timeup: entity.timeUp,
      createdat: entity.createdat,
      updatedat: entity.updatedat,
    );
  }

  NivelUser toEntity() {
    return NivelUser(
      id: uid,
      timeCria: timecria,
      lvl: lvl,
      quantity: quantity,
      minute: minute,
      userId: userid,
      timeUp: timeup,
      name: name,
      total: total,
      temporada: temporada,
      createdat: createdat ?? timecria,
      updatedat: updatedat ?? timeup,
    );
  }
}
