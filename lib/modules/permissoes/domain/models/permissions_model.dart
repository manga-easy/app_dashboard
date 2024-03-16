class Permissions {
  final String? id;
  final String userId;
  final int value;
  final int createdat;
  final int updatedat;
  const Permissions({
    required this.createdat,
    required this.updatedat,
    required this.userId,
    required this.value,
    this.id,
  });

  factory Permissions.empty() {
    return const Permissions(
      createdat: 0,
      updatedat: 0,
      userId: '',
      value: 0,
    );
  }

  Permissions copyWith({
    String? id,
    String? userId,
    int? value,
    int? createdat,
    int? updatedat,
  }) {
    return Permissions(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      createdat: createdat ?? this.createdat,
      updatedat: updatedat ?? this.updatedat,
    );
  }
}
