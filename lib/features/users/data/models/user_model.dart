class UserModel {
  final int userId;
  final String profileImage;
  final String displayName;

  UserModel({
    required this.userId,
    required this.profileImage,
    required this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as int,
      profileImage: map['profile_image'] as String,
      displayName: map['display_name'] as String,
    );
  }
}
