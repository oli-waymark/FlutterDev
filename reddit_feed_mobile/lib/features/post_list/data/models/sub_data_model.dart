import 'post_model.dart';
import '../../domain/entities/sub_data.dart';

class SubDataModel extends SubData {
  SubDataModel({
    this.children,
  }) : super(children: children);

  final List<PostModel> children;

  factory SubDataModel.fromJson(Map<String, dynamic> json) => SubDataModel(
        children: List<PostModel>.from(
            json["children"].map((x) => PostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}