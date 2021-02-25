import 'package:reddit_feed_mobile/core/data/database.dart';
import 'package:reddit_feed_mobile/core/errors/exceptions.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/post_data_model.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/post_model.dart';

import '../models/sub_data_model.dart';

abstract class PostsLocalDataSource {
  /// Gets the cached Subreddit data which was gotten the last
  /// time the user had an internet connection.
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<SubDataModel> getLastViewedPostList();

  Future<void> cachePosts(SubDataModel posts);

  Future<void> deleteAllCachedPosts();
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<SubDataModel> getLastViewedPostList() async {
    final db = await DBProvider.db.database;
    var res = await db.query("posts");

    var list = res.isNotEmpty
        ? res.map((item) => PostDataModel.fromJson(item)).toList()
        : List.empty();

    var postList = List<PostModel>();

    list.forEach((element) {
      var postModel = PostModel(data: element);
      postList.add(postModel);
    });
    var subData = SubDataModel(children: postList);

    if (subData.children.length > 0) {
      return subData;
    } else {
      throw CacheException();
    }
  }

  Future<void> cachePosts(SubDataModel posts) async {
    deleteAllCachedPosts();

    final db = await DBProvider.db.database;
    posts.children.forEach((element) async {
      await db.insert("posts", element.data.toJson());
    });
  }

  Future<void> deleteAllCachedPosts() async {
    final db = await DBProvider.db.database;
    db.delete('posts');
  }
}
