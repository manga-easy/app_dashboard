enum AchievementCategory {
  evento,
  doacao,
  rank;

  static AchievementCategory byName(String? name) {
    switch (name) {
      case 'evento':
        return AchievementCategory.evento;
      case 'doacao':
        return AchievementCategory.doacao;
      case 'rank':
        return AchievementCategory.rank;
      default:
        return AchievementCategory.evento;
    }
  }
}
