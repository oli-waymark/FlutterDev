import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/sub_data.dart';
import '../../domain/usecases/get_posts_from_subreddit.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsFromSubreddit getPostsFromSubreddit;

  PostsBloc({@required this.getPostsFromSubreddit}) : super(Empty());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is GetPostsFromFlutterDev) {
      yield Loading();
      var postList = await getPostsFromSubreddit(NoParams());

      yield* _eitherLoadedOrErrorState(postList);

      yield postList.fold(
        (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
        (posts) => Loaded(posts: posts.children),
      );
    }
  }

  Stream<PostsState> _eitherLoadedOrErrorState(
    Either<Failure, SubData> either,
  ) async* {
    yield either.fold(
      (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
      (posts) => Loaded(posts: posts.children),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Could not get data from server!';
      case CacheFailure:
        return 'Could not get data from local storage!';
      default:
        return 'Unexpected Error';
    }
  }
}
