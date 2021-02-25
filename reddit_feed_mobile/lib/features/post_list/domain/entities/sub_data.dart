import 'package:equatable/equatable.dart';
import 'post.dart';

class SubData extends Equatable {
  SubData({
    this.children,
  });

  final List<Post> children;

  @override
  List<Object> get props => [children];
}