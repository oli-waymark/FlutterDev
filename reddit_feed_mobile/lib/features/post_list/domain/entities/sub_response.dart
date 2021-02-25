import 'package:equatable/equatable.dart';
import 'sub_data.dart';

class SubResponse extends Equatable {
  SubResponse({
    this.data,
  });

  final SubData data;

  @override
  List<Object> get props => [data];
}