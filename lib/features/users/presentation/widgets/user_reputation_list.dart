import 'package:flutter/material.dart';
import 'package:sof_demo/features/users/domain/entities/user_reputation.dart';
import 'package:sof_demo/features/users/presentation/widgets/user_reputation_list_item.dart';

class UserReputationList extends StatelessWidget {
  final List<UserReputation> reputations;

  const UserReputationList({super.key, required this.reputations});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: UserReputationListItem(reputation: reputations[index]),
        );
      },
      itemCount: reputations.length,
    );
  }
}
