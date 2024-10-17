class Fix {
  final String title;
  final String subtitle;
  final String description;

  Fix({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class Feature {
  final String title;
  final String subtitle;
  final String description;

  Feature({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class UpdateNotesEntity {
  final String version;
  final String id;
  final String description;
  final List<Fix> fixes;
  final List<Feature> features;

  UpdateNotesEntity({
    required this.version,
    required this.description,
    required this.fixes,
    required this.id,
    required this.features,
  });
}
