import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class PermissionsDto {
  final String uid;
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
    );
  }
}
