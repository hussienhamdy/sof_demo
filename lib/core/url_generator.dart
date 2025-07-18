class URLGenerator {
  static const String baseUrl = 'https://api.stackexchange.com/2.2';

  static getUsersPath(int page, int pageSize) {
    return Uri.parse(
      '$baseUrl/users?page=$page&pagesize=$pageSize&site=stackoverflow',
    );
  }

  static getUsersByIdsPath(int page, int pageSize, List<int> usersIds) {
    final String idsString = usersIds.join(';');
    return Uri.parse(
      '$baseUrl/users/$idsString?page=$page&pagesize=$pageSize&site=stackoverflow',
    );
  }

  static getUserReputationPath(int page, int pageSize, int userId) {
    return Uri.parse(
      '$baseUrl/users/$userId/reputation-history?page=$page&pagesize=$pageSize&site=stackoverflow',
    );
  }
}
