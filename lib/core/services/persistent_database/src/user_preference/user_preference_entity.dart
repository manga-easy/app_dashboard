class UserPreferenceEntity {
  final dynamic value;
  final String id;

  UserPreferenceEntity({required this.value, required this.id});

  UserPreferenceEntity.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'id': id,
    };
  }
}
