import 'package:sof_demo/features/users/data/models/user_model.dart';

class GetUsersStateModel {
  final List<UserModel> users;
  final bool hasMoreData;
  GetUsersStateModel({required this.users, required this.hasMoreData});
}
