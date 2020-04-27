import 'dart:convert';
import 'package:test/test.dart';
import 'package:contentchef_dart/src/responses.dart';

final mockedResMetadata = {
  'authoringContentId': 1,
  'contentVersion': 1,
  'id': 1,
  'contentLastModifiedDate': DateTime(2020).toIso8601String(),
  'publishedOn': DateTime(2020).toIso8601String(),
  'tags': ['tag_1', 'tag_2'],
};
final mockedReqContext = {
  'publishingChannel': 'channel-test',
  'targetDate': DateTime(2020).toIso8601String(),
  'cloudName': 'test-cloud-name',
  'timestamp': DateTime(2020).toString(),
};
final mockedContentResult = {
  'definition': 'definition-mnemonic',
  'repository': 'repository-mnemonic',
  'publicId': 'content-publicId',
  'offlineDate': null,
  'onlineDate': DateTime(2020).toIso8601String(),
  'metadata': mockedResMetadata,
  'payload': { 'title': 'test-title' },
  'requestContext': mockedReqContext,
};
final mockedSearchResult = {
  'total': 1,
  'skip': 0,
  'take': 100,
  'requestContext': mockedReqContext,
  'items': [mockedContentResult]
};

void main() {
  group('Responses classes tests', () {
    ResponseMetadata responseMetadata;
    RequestContext requestContext;
    ContentResponse<dynamic> contentResponse;
    PaginatedResponse<dynamic> paginatedResponse;

    setUp(() {
      responseMetadata = ResponseMetadata(mockedResMetadata);
      requestContext = RequestContext(mockedReqContext);
      contentResponse = ContentResponse<dynamic>({
        ...mockedContentResult,
        'metadata': mockedResMetadata,
        'requestContext': mockedReqContext
      });
      paginatedResponse = PaginatedResponse<dynamic>({
        ...mockedSearchResult,
        'requestContext': mockedReqContext,
        'items': [{
          ...mockedContentResult,
          'metadata': mockedResMetadata,
          'requestContext': mockedReqContext
        }]
      });
    });

    test('ResponseMatadata toJson return a valid json', () {
      expect(jsonEncode(responseMetadata), equals(jsonEncode(mockedResMetadata)));
    });

    test('RequestContext toJson return a valid json', () {
      expect(jsonEncode(requestContext), equals(jsonEncode(mockedReqContext)));
    });

    test('ContentResponse toJson return a valid json', () {
      expect(jsonEncode(contentResponse), equals(jsonEncode(mockedContentResult)));
    });

    test('PaginatedResponse toJson return a valid json', () {
      expect(jsonEncode(paginatedResponse), equals(jsonEncode(mockedSearchResult)));
    });

  });
}
