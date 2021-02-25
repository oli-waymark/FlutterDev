import 'sub_data_model.dart';
import '../../domain/entities/sub_response.dart';

class SubResponseModel extends SubResponse {
  SubResponseModel({
    this.data,
  }) : super(data: data);

  final SubDataModel data;

  factory SubResponseModel.fromJson(Map<String, dynamic> json) =>
      SubResponseModel(
        data: SubDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
