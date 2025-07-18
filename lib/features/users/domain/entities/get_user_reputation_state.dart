import 'package:sof_demo/features/users/domain/entities/user_reputation.dart';

class GetUserReputationState {
  final List<UserReputation> reputations;
  final bool hasMoreData;
  final int page;
  GetUserReputationState({
    required this.reputations,
    required this.hasMoreData,
    this.page = 1,
  });

  @override
  String toString() =>
      'GetUserReputationState(reputations: $reputations, hasMoreData: $hasMoreData, page: $page)';
}
