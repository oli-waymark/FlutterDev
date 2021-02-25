import 'package:equatable/equatable.dart';

class PostData extends Equatable {
  PostData({this.authorFullName, this.title, this.name});
  final String authorFullName;
  final String title;
  final String name;

  @override
  List<Object> get props => [authorFullName, title, name];
}