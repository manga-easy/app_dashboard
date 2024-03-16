import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permissions_model.dart';

class PermissionsDto {
  final String? uid;
  final String userid;
  final int value;
  final int? createdat;
  final int? updatedat;

  PermissionsDto({
    required this.uid,
    required this.userid,
    required this.value,
    this.createdat,
    this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userid': userid,
      'value': value,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory PermissionsDto.fromMap(Map<String, dynamic> map) {
    return PermissionsDto(
      uid: map['uid'],
      userid: map['userid'],
      value: map['value'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }

  Permissions toEntity() {
    return Permissions(
      userId: userid,
      value: value,
      id: uid,
      createdat: createdat ?? 0,
      updatedat: updatedat ?? 0,
    );
  }

  factory PermissionsDto.fromEntity(Permissions entity) {
    return PermissionsDto(
      createdat: entity.createdat,
      uid: entity.id,
      userid: entity.userId,
      value: entity.value,
      updatedat: entity.updatedat,
    );
  }
}
