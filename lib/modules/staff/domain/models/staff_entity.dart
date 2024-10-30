class StaffEntity {
  final String id;
  final int createdAt;
  final int updatedAt;
  final StaffType type;
  final String userId;
  final String? name;
  final String? picture;

  StaffEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.userId,
    this.name,
    this.picture,
  });

  factory StaffEntity.empty() {
    return StaffEntity(
      id: '',
      createdAt: 0,
      updatedAt: 0,
      type: StaffType.unknown,
      userId: '',
      name: '',
      picture: '',
    );
  }

  StaffEntity copyWith({
    String? id,
    int? createdAt,
    int? updatedAt,
    StaffType? type,
    String? userId,
    String? name,
    String? picture,
  }) {
    return StaffEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }
}

enum StaffType { admin, support, designer, developer, unknown }
