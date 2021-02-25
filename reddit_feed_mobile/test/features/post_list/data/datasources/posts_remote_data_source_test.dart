import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_feed_mobile/core/errors/exceptions.dart';
import 'package:reddit_feed_mobile/features/post_list/data/datasources/posts_remote_data_source.dart';
import 'package:reddit_feed_mobile/features/post_list/data/models/sub_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PostsRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PostsRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('response.json'), 200));
  }

  void setUpMockFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Server Failed!', 404));
  }

  group('Get posts from FlutterDev subreddit', () {
    final tSubResponse =
        SubResponseModel.fromJson(json.decode(fixture('response.json')));

    test('Should perform a GET request with application/json header', () async {
      setUpMockSuccess();

      dataSource.getPostsFromFlutterDev();

      verify(mockHttpClient
          .get('https://www.reddit.com/r/FlutterDev.json', headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('Should return SubResponse when the response code is 200', () async {
      setUpMockSuccess();

      final result = await dataSource.getPostsFromFlutterDev();

      expect(result, equals(tSubResponse));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockFailure();
        // act
        final call = dataSource.getPostsFromFlutterDev;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
