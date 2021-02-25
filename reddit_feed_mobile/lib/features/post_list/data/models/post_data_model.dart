import '../../domain/entities/post_data.dart';

class PostDataModel extends PostData {
  PostDataModel({this.authorFullName, this.title, this.name})
      : super(authorFullName: authorFullName, title: title, name: name);

  final String authorFullName;
  final String title;
  final String name;

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        title: json["title"],
        name: json["name"],
        authorFullName: json["author_fullname"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "author_fullname": authorFullName,
      };
}
