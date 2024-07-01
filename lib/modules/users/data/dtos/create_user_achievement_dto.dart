class CreateUserAchievementDto {
  final String achievementId;
  final String userId;

  CreateUserAchievementDto({
    required this.achievementId,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'achievementId': achievementId,
      'userId': userId,
    };
  }

  static CreateUserAchievementDto empty() {
    return CreateUserAchievementDto(
      achievementId: '',
      userId: '',
    );
  }
}
