import 'package:dashboard_manga_easy/modules/permissoes/domain/models/level_permissoes_enum.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';

class StaffDto {
  final String id;
  final int createdAt;
  final int updatedAt;
  final String type;
  final String userId;

  StaffDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.userId,
  });

  factory StaffDto.empty() {
    return StaffDto(
      id: '',
      createdAt: 0,
      updatedAt: 0,
      type: 'unknown',
      userId: '',
    );
  }

  factory StaffDto.fromJson(Map<String, dynamic> json) {
    return StaffDto(
      id: json['id'] as String,
      createdAt: json['createdAt'] as int,
      updatedAt: json['updatedAt'] as int,
      type: json['type'] as String,
      userId: json['userId'] as String,
    );
  }

  StaffEntity toEntity() {
    return StaffEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      type: _mapStringToStaffType(type),
      userId: userId,
    );
  }

  factory StaffDto.fromEntity(StaffEntity entity) {
    return StaffDto(
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      type: _mapStaffTypeToString(entity.type),
      userId: entity.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'type': type,
      'userId': userId,
    };
  }

  static StaffType _mapStringToStaffType(String type) {
    switch (type.toLowerCase()) {
      case 'admin':
        return StaffType.admin;
      case 'support':
        return StaffType.support;
      default:
        return StaffType.unknown;
    }
  }

  static String _mapStaffTypeToString(StaffType type) {
    switch (type) {
      case StaffType.admin:
        return 'Admin';
      case StaffType.support:
        return 'Support';
      case StaffType.developer:
        return 'Developer';
      case StaffType.designer:
        return 'Designer';
      default:
        return 'unknown';
    }
  }

  static StaffType converter(LevelPermissoes level) {
    switch (level) {
      case LevelPermissoes.admin:
        return StaffType.admin;
      case LevelPermissoes.suporte:
        return StaffType.support;
      default:
        return StaffType.unknown;
    }
  }
}
