import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/services/api_service.dart';
import 'package:sof_demo/features/users/data/datasource/users_local_datasource.dart';
import 'package:sof_demo/features/users/data/datasource/users_remote_datasource.dart';
import 'package:sof_demo/features/users/data/repositories/users_repository_impl.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiService.getInstance(),
);

final usersRemoteDataSourceProvider = Provider<UsersRemoteDatasource>(
  (ref) => UsersRemoteDatasourceImpl(ref.watch(apiServiceProvider)),
);

final usersLocalDataSourceProvider = Provider<UsersLocalDatasource>(
  (ref) => UsersLocalDatasourceImplHive(),
);

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UsersRepositoryImpl(
    ref.watch(usersRemoteDataSourceProvider),
    ref.watch(usersLocalDataSourceProvider),
  ),
);
