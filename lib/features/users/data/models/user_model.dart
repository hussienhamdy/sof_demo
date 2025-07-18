import 'package:sof_demo/features/users/data/models/badge_count_model.dart';

class UserModel {
  final int userId;
  final String profileImage;
  final String displayName;
  final BadgeCountModel badgeCount;

  UserModel({
    required this.userId,
    required this.profileImage,
    required this.displayName,
    required this.badgeCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as int,
      profileImage: map['profile_image'] as String,
      displayName: map['display_name'] as String,
      badgeCount: BadgeCountModel.fromJson(
        map['badge_counts'] as Map<String, dynamic>,
      ),
    );
  }
}
