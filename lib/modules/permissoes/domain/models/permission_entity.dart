class Permission {
  final String id;
  final String userId;
  final int level;
  final int createdAt;
  final int updatedAt;
  const Permission({
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.level,
    required this.id,
  });

  Permission copyWith({
    String? id,
    String? userId,
    int? level,
    int? createdAt,
    int? updatedAt,
  }) {
    return Permission(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      id: map['id'] as String,
      userId: map['userId'] as String,
      level: map['level'] as int,
      createdAt: map['createdAt'] as int,
      updatedAt: map['updatedAt'] as int,
    );
  }
}
