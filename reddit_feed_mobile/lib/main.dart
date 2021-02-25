import 'package:flutter/material.dart';

import 'features/post_list/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'r/FlutterDev', home: PostsPage());
  }
}
