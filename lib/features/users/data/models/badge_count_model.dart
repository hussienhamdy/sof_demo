class BadgeCountModel {
  final int bronzeCount;
  final int silverCount;
  final int goldCount;

  BadgeCountModel({
    required this.bronzeCount,
    required this.silverCount,
    required this.goldCount,
  });
  factory BadgeCountModel.fromJson(Map<String, dynamic> map) {
    return BadgeCountModel(
      bronzeCount: map['bronze'] as int,
      silverCount: map['silver'] as int,
      goldCount: map['gold'] as int,
    );
  }
}
