import 'package:flutter/material.dart';
import 'package:sof_demo/features/users/presentation/screens/bookmarked_users_screen.dart';
import 'package:sof_demo/features/users/presentation/screens/user_reputation_history_screen.dart';

class Routes {
  static const bookmarkedUsersScreen = '/bookmarkedUsersScreen';
  static const userReputationsScreen = '/userReputationsScreen';

  MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    var routes = <String, WidgetBuilder>{
      bookmarkedUsersScreen: (context) => BookmarkedUsersScreen(),
      userReputationsScreen: (context) =>
          UserReputationHistoryScreen(userId: settings.arguments as int),
    };

    WidgetBuilder? builder = routes[settings.name!];
    if (builder == null) {
      return null;
    }
    return MaterialPageRoute(
      builder: (context) => builder(context),
      settings: settings,
    );
  }
}
