class ToggleEntity {
  final String name;
  final int updateAt;
  final String status;
  final String description;
  final dynamic value;
  final String id;

  const ToggleEntity({
    required this.name,
    required this.updateAt,
    required this.status,
    required this.description,
    required this.value,
    required this.id,
  });

  factory ToggleEntity.fromJson(Map<String, dynamic> json) {
    return ToggleEntity(
      name: json['name'],
      updateAt: json['updateAt'],
      status: json['status'],
      description: json['description'],
      value: json['value'],
      id: json['id'],
    );
  }
}
