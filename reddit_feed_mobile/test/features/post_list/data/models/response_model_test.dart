import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/post_data_model.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/post_model.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/sub_data_model.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/sub_response_model.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/post_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/sub_data.dart';
import 'package:reddit_feed_mobile/features/post_list/domain/entities/sub_response.dart';

void main() {
  final tPostData = PostDataModel(name: 'Test', title: 'Test Title');
  final tPost = PostModel(data: tPostData);
  final tPostList = List<PostModel>();

  tPostList.add(tPost);

  final tSubData = SubDataModel(children: tPostList);

  final tSubResponse = SubResponseModel(data: tSubData);

  group('should be a subclass of Entity', () {
    test('SubResponse Model should be a subclass of SubResponse entity',
        () async {
      expect(tSubResponse, isA<SubResponse>());
    });

    test('SubDataModel Model should be a subclass of SubData entity', () async {
      expect(tSubData, isA<SubData>());
    });

    test('PostModel Model should be a subclass of Post entity', () async {
      expect(tPost, isA<Post>());
    });

    test('PostDataModel Model should be a subclass of PostData entity',
        () async {
      expect(tPostData, isA<PostData>());
    });
  });
}
