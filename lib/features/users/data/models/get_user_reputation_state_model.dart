import 'package:sof_demo/features/users/data/models/user_reputation_model.dart';

class GetUserReputationStateModel {
  final List<UserReputationModel> reputations;
  final bool hasMoreData;
  GetUserReputationStateModel({
    required this.reputations,
    required this.hasMoreData,
  });
}
