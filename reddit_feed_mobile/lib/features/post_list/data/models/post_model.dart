import 'post_data_model.dart';
import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    this.data,
  }) : super(data: data);

  final PostDataModel data;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        data: PostDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}