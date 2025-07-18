class UserReputationModel {
  final String reputationHistoryType;
  final int reputationChange;
  final int postId;
  final int creationDate;
  final int userId;
  UserReputationModel({
    required this.reputationHistoryType,
    required this.reputationChange,
    required this.postId,
    required this.creationDate,
    required this.userId,
  });

  factory UserReputationModel.fromJson(Map<String, dynamic> map) {
    return UserReputationModel(
      userId: map['user_id'] as int,
      postId: map['post_id'] as int,
      reputationHistoryType: map['reputation_history_type'] as String,
      reputationChange: map['reputation_change'] as int,
      creationDate: map['creation_date'] as int,
    );
  }
}
