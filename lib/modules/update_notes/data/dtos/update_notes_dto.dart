import 'package:dashboard_manga_easy/modules/update_notes/domain/update_notes_entity.dart';

class FixDto {
  String title;
  String subtitle;
  String description;

  FixDto({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory FixDto.fromJson(Map<String, dynamic> json) {
    return FixDto(
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
    );
  }

  factory FixDto.empty() {
    return FixDto(
      title: '',
      subtitle: '',
      description: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }

  Fix toEntity() {
    return Fix(
      title: title,
      subtitle: subtitle,
      description: description,
    );
  }

  static FixDto fromEntity(Fix entity) {
    return FixDto(
      title: entity.title,
      subtitle: entity.subtitle,
      description: entity.description,
    );
  }
}

class FeatureDto {
  String title;
  String subtitle;
  String description;

  FeatureDto({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory FeatureDto.fromJson(Map<String, dynamic> json) {
    return FeatureDto(
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
    );
  }

  factory FeatureDto.empty() {
    return FeatureDto(
      title: '',
      subtitle: '',
      description: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }

  Feature toEntity() {
    return Feature(
      title: title,
      subtitle: subtitle,
      description: description,
    );
  }

  static FeatureDto fromEntity(Feature entity) {
    return FeatureDto(
      title: entity.title,
      subtitle: entity.subtitle,
      description: entity.description,
    );
  }
}

class UpdateNotesDto {
  String version;
  String description;
  List<FixDto> fixes;
  String id;
  List<FeatureDto> features;

  UpdateNotesDto({
    required this.id,
    required this.version,
    required this.description,
    required this.fixes,
    required this.features,
  });

  factory UpdateNotesDto.fromJson(Map<String, dynamic> json) {
    return UpdateNotesDto(
      id: json['id'],
      version: json['version'],
      description: json['description'],
      fixes: (json['fixes'] as List)
          .map((fixJson) => FixDto.fromJson(fixJson))
          .toList(),
      features: (json['features'] as List)
          .map((featureJson) => FeatureDto.fromJson(featureJson))
          .toList(),
    );
  }

  factory UpdateNotesDto.empty() {
    return UpdateNotesDto(
      version: '',
      id: '',
      description: '',
      fixes: [],
      features: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'description': description,
      'fixes': fixes.map((fixDto) => fixDto.toJson()).toList(),
      'features': features.map((featureDto) => featureDto.toJson()).toList(),
    };
  }

  UpdateNotesEntity toEntity() {
    return UpdateNotesEntity(
      version: version,
      description: description,
      id: id,
      fixes: fixes.map((fixDto) => fixDto.toEntity()).toList(),
      features: features.map((featureDto) => featureDto.toEntity()).toList(),
    );
  }

  static UpdateNotesDto fromEntity(UpdateNotesEntity entity) {
    return UpdateNotesDto(
      id: entity.id,
      version: entity.version,
      description: entity.description,
      fixes: entity.fixes.map((fix) => FixDto.fromEntity(fix)).toList(),
      features: entity.features
          .map((feature) => FeatureDto.fromEntity(feature))
          .toList(),
    );
  }
}
