import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';

class StaffDto {
  final String id;
  final int createdAt;
  final int updatedAt;
  final String type;
  final String userId;
  final String? name;
  final String? picture;

  StaffDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.userId,
    this.name,
    this.picture,
  });

  factory StaffDto.empty() {
    return StaffDto(
      id: '',
      createdAt: 0,
      updatedAt: 0,
      type: StaffType.unknown.name,
      userId: '',
      name: '',
      picture: '',
    );
  }

  factory StaffDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> staff = json['staff'];

    return StaffDto(
      name: json['userName'] as String?,
      picture: json['userImage'] as String?,
      id: staff['id'] as String,
      createdAt: staff['createdAt'] as int,
      updatedAt: staff['updatedAt'] as int,
      type: staff['type'] as String,
      userId: staff['userId'] as String,
    );
  }

  StaffEntity toEntity() {
    return StaffEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      type: mapStringToStaffType(type),
      userId: userId,
      name: name,
      picture: picture,
    );
  }

  factory StaffDto.fromEntity(StaffEntity entity) {
    return StaffDto(
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      name: entity.name,
      picture: entity.picture,
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
      'name': name,
      'picture': picture,
    };
  }

  static StaffType mapStringToStaffType(String type) {
    switch (type.toLowerCase()) {
      case 'admin':
        return StaffType.admin;
      case 'support':
        return StaffType.support;
      case 'developer':
        return StaffType.developer;
      case 'designer':
        return StaffType.designer;
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
}
