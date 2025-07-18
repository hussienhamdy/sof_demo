import 'package:flutter/material.dart';
import 'package:sof_demo/features/users/domain/entities/user.dart';
import 'package:sof_demo/features/users/presentation/widgets/user_list_item.dart';

class UsersList extends StatelessWidget {
  final List<User> users;
  const UsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: UserListItem(user: users[index]),
        );
      },
      itemCount: users.length,
    );
  }
}
