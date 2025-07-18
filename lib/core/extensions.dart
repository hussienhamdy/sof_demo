import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sof_demo/core/enums.dart';

extension ReputationHistoryTypeExtension on ReputationHistoryType {
  String get displayName {
    switch (this) {
      case ReputationHistoryType.post_upvoted:
        return 'Post Upvoted';
      case ReputationHistoryType.post_downvoted:
        return 'Post Downvoted';
      case ReputationHistoryType.post_unupvoted:
        return 'Post Un-Upvoted';
      case ReputationHistoryType.post_undownvoted:
        return 'Post Un-Downvoted';
      case ReputationHistoryType.user_deleted:
        return 'User Deleted';
      case ReputationHistoryType.answer_accepted:
        return 'Answer Accepted';
      case ReputationHistoryType.answer_unaccepted:
        return 'Answer Unaccepted';
    }
  }

  IconData get icon {
    switch (this) {
      case ReputationHistoryType.post_upvoted:
        return Icons.arrow_circle_up_rounded;
      case ReputationHistoryType.post_downvoted:
        return Icons.arrow_circle_down_rounded;
      case ReputationHistoryType.post_unupvoted:
        return Icons.undo_rounded;
      case ReputationHistoryType.post_undownvoted:
        return Icons.undo_rounded;
      case ReputationHistoryType.user_deleted:
        return Icons.delete;
      case ReputationHistoryType.answer_accepted:
        return Icons.check_circle_rounded;
      case ReputationHistoryType.answer_unaccepted:
        return Icons.close_rounded;
    }
  }

  Color get iconColor {
    switch (this) {
      case ReputationHistoryType.post_upvoted:
      case ReputationHistoryType.answer_accepted:
        return Colors.green;
      case ReputationHistoryType.post_downvoted:
      case ReputationHistoryType.user_deleted:
      case ReputationHistoryType.answer_unaccepted:
        return Colors.red;
      case ReputationHistoryType.post_unupvoted:
      case ReputationHistoryType.post_undownvoted:
        return Colors.orange;
    }
  }
}

extension DateTimeExtension on int {
  DateTime get dateTime {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}

extension FormattedDateExtension on DateTime {
  String get formattedDate {
    final String formattedDate = DateFormat('MMM d, yyyy h:mm a').format(this);
    return formattedDate;
  }
}
