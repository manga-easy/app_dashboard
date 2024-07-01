class UserAchievement {
  final int id;
  final String achievementId;
  final String userId;
  final int createdAt;

  UserAchievement({
    required this.id,
    required this.achievementId,
    required this.userId,
    required this.createdAt,
  });

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      id: json['id'],
      achievementId: json['achievementId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
    );
  }

  static UserAchievement empty() {
    return UserAchievement(
      id: 0,
      achievementId: '',
      userId: '',
      createdAt: 0,
    );
  }
}
