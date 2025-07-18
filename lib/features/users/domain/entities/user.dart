import 'package:sof_demo/features/users/domain/entities/badge_count.dart';

class User {
  final int userId;
  final String profileImage;
  final String displayName;
  final BadgeCount badgeCount;

  User({
    required this.userId,
    required this.profileImage,
    required this.displayName,
    required this.badgeCount,
  });

  User copyWith({
    int? userId,
    String? profileImage,
    String? displayName,
    bool? isBookmarked,
    BadgeCount? badgeCount,
  }) {
    return User(
      userId: userId ?? this.userId,
      profileImage: profileImage ?? this.profileImage,
      displayName: displayName ?? this.displayName,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
