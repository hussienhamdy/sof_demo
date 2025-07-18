import 'package:hive/hive.dart';
import 'package:sof_demo/core/constants.dart';

abstract class UsersLocalDatasource {
  Future<bool> bookmarkUser(int userId);
  Future<bool> debookmarkUser(int userId);
  Future<Set<int>> getAllBookmarkedUserIds();
}

class UsersLocalDatasourceImplHive implements UsersLocalDatasource {
  @override
  Future<bool> bookmarkUser(int userId) async {
    try {
      await Hive.box(bookmarkedUsersBoxName).put(userId, true);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> debookmarkUser(int userId) async {
    try {
      await Hive.box(bookmarkedUsersBoxName).delete(userId);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Set<int>> getAllBookmarkedUserIds() async {
    try {
      return Hive.box(bookmarkedUsersBoxName).keys.cast<int>().toSet();
    } catch (e) {
      rethrow;
    }
  }
}
