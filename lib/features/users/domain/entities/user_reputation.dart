import 'package:sof_demo/core/enums.dart';

class UserReputation {
  final int userId;
  final int postId;
  final int reputationChange;
  final ReputationHistoryType reputationHistoryType;
  final DateTime creationDate;

  UserReputation({
    required this.userId,
    required this.postId,
    required this.reputationChange,
    required this.reputationHistoryType,
    required this.creationDate,
  });

  UserReputation copyWith({
    int? userId,
    int? postId,
    int? reputationChange,
    ReputationHistoryType? reputationHistoryType,
    DateTime? creationDate,
  }) {
    return UserReputation(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      reputationChange: reputationChange ?? this.reputationChange,
      reputationHistoryType:
          reputationHistoryType ?? this.reputationHistoryType,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
