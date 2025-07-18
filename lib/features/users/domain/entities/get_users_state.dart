// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sof_demo/features/users/domain/entities/user.dart';

class GetUsersState {
  final List<User> users;
  final bool hasMoreData;
  final int page;
  GetUsersState({
    required this.users,
    required this.hasMoreData,
    this.page = 1,
  });

  @override
  String toString() =>
      'GetUsersState(users: ${users.length}, hasMoreData: $hasMoreData, page: $page)';
}
