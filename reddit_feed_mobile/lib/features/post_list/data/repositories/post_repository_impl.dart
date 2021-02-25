import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/sub_data.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../datasources/posts_local_data_source.dart';
import '../datasources/posts_remote_data_source.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsLocalDataSource localDataSource;
  final PostsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, SubData>> getAListOfPostsFromFlutterDev() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await remoteDataSource.getPostsFromFlutterDev();

        var postList = remoteResponse.data;

        await localDataSource.cachePosts(postList);

        return Right(postList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localResponse = await localDataSource.getLastViewedPostList();
        return Right(localResponse);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
