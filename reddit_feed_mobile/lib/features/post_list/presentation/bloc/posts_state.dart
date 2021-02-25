part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class Empty extends PostsState {}

class Loading extends PostsState {}

class Loaded extends PostsState {
  final List<Post> posts;

  Loaded({@required this.posts});

  @override
  List<Object> get props => [posts];
}

class Error extends PostsState {
  final String errorMessage;

  Error({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
