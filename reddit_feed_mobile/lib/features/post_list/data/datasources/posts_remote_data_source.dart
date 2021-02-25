import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../models/sub_response_model.dart';
import '../../../../core/errors/exceptions.dart';

abstract class PostsRemoteDataSource {
  /// Makes a Request to get a List of posts from r/FlutterDev
  /// Throws a [ServerException] for all error codes.
  Future<SubResponseModel> getPostsFromFlutterDev();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl({@required this.client});

  @override
  Future<SubResponseModel> getPostsFromFlutterDev() =>
      _getPostsFromUrl('https://www.reddit.com/r/FlutterDev.json');

  Future<SubResponseModel> _getPostsFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var response2 = SubResponseModel.fromJson(json.decode(response.body));

      return response2;
    } else {
      throw ServerException();
    }
  }
}
