import 'package:dashboard_manga_easy/modules/permissoes/domain/models/permission_entity.dart';

class CreatePermissionDto {
  final String userId;
  final int value;

  CreatePermissionDto({required this.userId, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'value': value,
    };
  }

  factory CreatePermissionDto.empty() {
    return CreatePermissionDto(
      userId: '',
      value: 0,
    );
  }

  factory CreatePermissionDto.fromEntity(Permission entity) {
    return CreatePermissionDto(
      userId: entity.userId,
      value: entity.level,
    );
  }

  CreatePermissionDto copyWith({
    String? userId,
    int? value,
  }) {
    return CreatePermissionDto(
      userId: userId ?? this.userId,
      value: value ?? this.value,
    );
  }
}
