import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/posts_bloc.dart';
import '../widgets/widgets.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('r/FlutterDev'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<PostsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PostsBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state is Empty) {
                    context.read<PostsBloc>().add(GetPostsFromFlutterDev());
                    return LoadingWidget();
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return Expanded(
                      child: PostListDisplay(postList: state.posts),
                    );
                  } else if (state is Error) {
                    return MessageWidget(
                      message: state.errorMessage,
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
