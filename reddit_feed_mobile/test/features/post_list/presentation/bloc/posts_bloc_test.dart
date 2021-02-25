import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit_feed_mobile/core/usecases/usecases.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/sub_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/usecases/get_posts_from_subreddit.dart';
import 'package:reddit_feed_mobile/features/post_list/presentation/bloc/posts_bloc.dart';

class MockGetPostsFromSubreddit extends Mock implements GetPostsFromSubreddit {}

void main() {
  PostsBloc bloc;
  MockGetPostsFromSubreddit mockGetPostsFromSubreddit;

  setUp(() {
    mockGetPostsFromSubreddit = MockGetPostsFromSubreddit();
    bloc = PostsBloc(getPostsFromSubreddit: mockGetPostsFromSubreddit);
  });

  group('Get Posts from Subreddit', () {
    final tPostData = PostData(title: 'Test Post Title', name: 'test_name');
    final tPost = Post(data: tPostData);
    final tList = List<Post>();
    tList.add(tPost);

    final tPostList = SubData(children: tList);
    test('should get data from the Get Posts from subreddit usecase', () async {
      // arrange
      when(mockGetPostsFromSubreddit(any))
          .thenAnswer((_) async => Right(tPostList));
      // act
      bloc.add(GetPostsFromFlutterDev());
      await untilCalled(mockGetPostsFromSubreddit(any));
      // assert
      verify(mockGetPostsFromSubreddit(NoParams()));
    });
  });
}
