import 'package:equatable/equatable.dart';

import 'post_data.dart';

class Post extends Equatable {
  Post({
    this.data,
  });

  final PostData data;

  @override
  List<Object> get props => [data];
}
