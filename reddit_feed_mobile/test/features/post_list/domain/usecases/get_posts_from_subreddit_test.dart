import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reddit_feed_mobile/core/usecases/usecases.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/sub_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/repositories/post_repository.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/usecases/get_posts_from_subreddit.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  GetPostsFromSubreddit usecase;
  MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetPostsFromSubreddit(mockPostRepository);
  });

  final tPostData = PostData(title: 'Test Post Title', name: 'test_name');
  final tPost = Post(data: tPostData);
  final tList = List<Post>();
  tList.add(tPost);

  final tPostList = SubData(children: tList);

  test('should get a list of subreddit posts from the repository', () async {
    when(mockPostRepository.getAListOfPostsFromFlutterDev())
        .thenAnswer((_) async => Right(tPostList));

    final result = await usecase(NoParams());

    expect(result, Right(tPostList));
    verify(mockPostRepository.getAListOfPostsFromFlutterDev());
    verifyNoMoreInteractions(mockPostRepository);
  });
}
