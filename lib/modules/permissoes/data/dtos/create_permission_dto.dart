class CreatePermissionDto {
  final String userid;
  final int value;

  CreatePermissionDto({required this.userid, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'value': value,
    };
  }

  factory CreatePermissionDto.fromMap(Map<String, dynamic> map) {
    return CreatePermissionDto(
      userid: map['userid'] as String,
      value: map['value'] as int,
    );
  }

  static CreatePermissionDto empty() {
    return CreatePermissionDto(
      userid: '',
      value: 0,
    );
  }

  CreatePermissionDto copyWith({
    String? userid,
    int? value,
  }) {
    return CreatePermissionDto(
      userid: userid ?? this.userid,
      value: value ?? this.value,
    );
  }
}
