class User {
  final int userId;
  final String profileImage;
  final String displayName;

  User({
    required this.userId,
    required this.profileImage,
    required this.displayName,
  });

  User copyWith({
    int? userId,
    String? profileImage,
    String? displayName,
    bool? isBookmarked,
  }) {
    return User(
      userId: userId ?? this.userId,
      profileImage: profileImage ?? this.profileImage,
      displayName: displayName ?? this.displayName,
    );
  }
}
