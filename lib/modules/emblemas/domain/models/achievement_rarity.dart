enum AchievementRarity {
  comum(label: 'Comum'),
  incomum(label: 'Incomum'),
  raro(label: 'Raro'),
  mitico(label: 'Mítico'),
  lendario(label: 'Lendário'),
  unico(label: 'Único');

  const AchievementRarity({required this.label});

  final String label;

  static AchievementRarity byName(String? name) {
    switch (name) {
      case 'comum':
        return AchievementRarity.comum;
      case 'incomum':
        return AchievementRarity.incomum;
      case 'lendario':
        return AchievementRarity.lendario;
      case 'mitico':
        return AchievementRarity.mitico;
      case 'raro':
        return AchievementRarity.raro;
      case 'unico':
        return AchievementRarity.unico;
      default:
        return AchievementRarity.comum;
    }
  }
}
