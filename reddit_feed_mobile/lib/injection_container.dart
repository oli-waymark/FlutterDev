import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/platform/network_info.dart';
import 'features/post_list/data/datasources/posts_local_data_source.dart';
import 'features/post_list/data/datasources/posts_remote_data_source.dart';
import 'features/post_list/data/repositories/post_repository_impl.dart';
import 'features/post_list/domain/repositories/post_repository.dart';
import 'features/post_list/domain/usecases/get_posts_from_subreddit.dart';
import 'features/post_list/presentation/bloc/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features
  // Bloc
  sl.registerFactory(() => PostsBloc(getPostsFromSubreddit: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetPostsFromSubreddit(sl()));

  // Data sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl());

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => DataConnectionChecker());
}
