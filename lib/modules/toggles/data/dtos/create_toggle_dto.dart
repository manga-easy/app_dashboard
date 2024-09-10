import 'package:dashboard_manga_easy/modules/toggles/domain/entities/toggle_entity.dart';

class CreateToggleDto {
  String name;
  String description;
  String value;

  CreateToggleDto({
    required this.name,
    required this.description,
    required this.value,
  });

  factory CreateToggleDto.fromEntity(ToggleEntity entity) {
    return CreateToggleDto(
      name: entity.name,
      description: entity.description,
      value: entity.value,
    );
  }

  factory CreateToggleDto.empty() {
    return CreateToggleDto(
      name: '',
      description: '',
      value: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'value': value,
    };
  }
}
