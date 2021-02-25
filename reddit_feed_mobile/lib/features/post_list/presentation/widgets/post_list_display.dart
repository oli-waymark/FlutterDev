import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';

class PostListDisplay extends StatelessWidget {
  final List<Post> postList;

  const PostListDisplay({
    Key key,
    @required this.postList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final item = postList[index];
            return ListTile(
              title: Text(item.data.title),
              subtitle: Text(item.data.name),
            );
          },
          itemCount: postList.length,
        ),
      ],
    );
  }
}
