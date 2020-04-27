import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:contentchef_dart/contentchef_dart.dart';
import 'package:contentchef_dart/src/configuration.dart';
import 'package:contentchef_dart/src/request_executor.dart';

final mockedContent = {
  'definition': 'test-definition',
  'repository': 'test-repository',
  'publicId': 'test-publicId',
  'offlineDate': null,
  'onlineDate': null,
  'metadata': {
    'authoringContentId': 1,
    'id': 1,
    'contentLastModifiedDate': DateTime(2020).toIso8601String(),
    'publishedOn': DateTime(2020).toIso8601String(),
    'tags': ['tag_1']
  },
  'payload': { 'title': 'test title' },
  'requestContext': {
    'publishingChannel': 'testPublishingChannel',
    'tagetDate': DateTime(2020).toIso8601String(),
    'cloudName': 'testCloudName',
    'timestamp': DateTime(2020).toString(),
  }
};

final mockedSearch = {
  'items': [mockedContent],
  'total': 1,
  'skip': 0,
  'take': 10,
  'requestContext': {
    'publishingChannel': 'testPublishingChannel',
    'tagetDate': DateTime(2020).toIso8601String(),
    'cloudName': 'testCloudName',
    'timestamp': DateTime(2020).toString(),
  }
};


void main() {
  group('Request executor tests', () {
    group('executeGetContentRequest tests', () {
      test('return a ContentResponse if http request completes succesfully', () async {
        final mockedConfiguration = Configuration(
            spaceId: 'test-spaceId',
            host: 'fake-host-for-tests',
            timeout: 5000,
            client: MockClient((request) async {
              return Response(jsonEncode(mockedContent), 200);
            })
        );
        final getContentFilters = GetContentFilters(publicId: 'test-publicId');
        final result = RequestExecutor().executeGetContentRequest(
            path: 'a/test/path', apiKey: 'a-test-key', config: mockedConfiguration, filters: getContentFilters
        );
        expect(await result, const TypeMatcher<ContentResponse>());
      });
      test('throw an exception if the http request fail', () async {
        final mockedConfiguration = Configuration(
            spaceId: 'test-spaceId',
            host: 'fake-host-for-tests',
            timeout: 5000,
            client: MockClient((request) async {
              return Response('Not Found', 404);
            })
        );
        final getContentFilters = GetContentFilters(publicId: 'test-publicId');
        final result = RequestExecutor().executeGetContentRequest(
            path: 'a/test/path', apiKey: 'a-test-key', config: mockedConfiguration, filters: getContentFilters
        );
        expect(() async => await result, throwsException);
      });
    });

    group('executeSearchContentsRequest test', () {
      test('return a ContentResponse if http request completes succesfully', () async {
        final mockedConfiguration = Configuration(
            spaceId: 'test-spaceId',
            host: 'fake-host-for-tests',
            timeout: 5000,
            client: MockClient((request) async {
              return Response(jsonEncode(mockedSearch), 200);
            })
        );
        final getContentFilters = SearchContentsFilters(take: 10, skip: 0, publicId: ['test-publicId']);
        final result = RequestExecutor().executeSearchContentsRequest(
            path: 'a/test/path', apiKey: 'a-test-key', config: mockedConfiguration, filters: getContentFilters
        );
        expect(await result, const TypeMatcher<PaginatedResponse>());
      });
      test('throw an exception if the http request fail', () async {
        final mockedConfiguration = Configuration(
            spaceId: 'test-spaceId',
            host: 'fake-host-for-tests',
            timeout: 5000,
            client: MockClient((request) async {
              return Response('Forbidden', 503);
            })
        );
        final getContentFilters = SearchContentsFilters(take: 10, skip: 0, publicId: ['test-publicId']);
        final result = RequestExecutor().executeSearchContentsRequest(
            path: 'a/test/path', apiKey: 'a-test-key', config: mockedConfiguration, filters: getContentFilters
        );
        expect(() async => await result, throwsException);
      });
    });
  });
}
