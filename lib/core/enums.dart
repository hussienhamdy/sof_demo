// ignore_for_file: constant_identifier_names

enum ReputationHistoryType {
  post_upvoted,
  post_downvoted,
  post_unupvoted,
  post_undownvoted,
  user_deleted,
  answer_accepted,
  answer_unaccepted,
}

class EnumHandler {
  static T? enumFromString<T>(Iterable<T> values, String? value) {
    if (value == null) {
      return null;
    }
    return values.firstWhere(
      (type) => type.toString().split(".").last == value.toLowerCase(),
    );
  }

  static String? stringFromEnum(dynamic value) {
    if (value == null) {
      return null;
    }
    return value.toString().split('.').last.toLowerCase();
  }
}
