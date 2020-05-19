import 'package:contentchef_dart/contentchef_dart.dart';
import 'package:contentchef_dart/src/channels.dart';
import 'package:contentchef_dart/src/request_executor.dart';
import 'package:contentchef_dart/src/responses.dart';
import 'package:contentchef_dart/src/urls.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedRequestExecutor extends Mock implements RequestExecutor {}
class MockedContentResponse extends Mock implements ContentResponse<MockedContentResult> {}
class MockedPaginatedResponse extends Mock implements PaginatedResponse<MockedContentResult> {}
class MockedContentResult {
  String testAttribute;
  String testAttribute2;

  MockedContentResult({
    this.testAttribute,
    this.testAttribute2,
  });

  static MockedContentResult fromJson(Map<String, dynamic> json) {
    return MockedContentResult(
      testAttribute: json['testAttribute'] as String,
      testAttribute2: json['testAttribute2'] as String,
    );
  }
}

void main () {
  final publicId = 'test-publicId';
  final apiKey = 'test-api-key';
  final publishingChannel = 'test-ch';
  final config = Configuration(spaceId: 'test-spaceId');

  group('Channels tests', () {
    final mockedGetResult = Future.value(MockedContentResponse());
    final mockedPaginatedResult = Future.value(MockedPaginatedResponse());
    group('OnlineChannel tests', () {
      test('Initialize successfully', () {
        expect(OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: MockedRequestExecutor(),
        ),
          const TypeMatcher<OnlineChannel>()
        );
      });
      test('Initialize throw an exception if apiKey is null', () {
        expect(() => OnlineChannel(
          config: config,
          apiKey: null,
          publishingChannel: publishingChannel,
          requestExecutor: MockedRequestExecutor(),
        ),
          throwsException);
      });
      test('Initialize throw an exception if publishingChannel is null', () {
        expect(() => OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: null,
          requestExecutor: MockedRequestExecutor(),
        ),
          throwsException);
      });
      test('Initialize throw an exception if requestExecutor is null', () {
        expect(() => OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: null,
        ),
          throwsException
        );
      });
      test('getContent method should call RequestExecutor.executeGetContentRequest method', () async {
        final getContentFilters = GetContentFilters(publicId: publicId);
        final requestPath = getOnlinePath(spaceId: config.spaceId, requestType: RequestTypes.content, channel: publishingChannel);
        final mockedRequestExecutor = MockedRequestExecutor();
        when(mockedRequestExecutor.executeGetContentRequest<MockedContentResult>(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: getContentFilters,
          fromJson: MockedContentResult.fromJson)
        ).thenAnswer((_) => mockedGetResult);
        await OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: mockedRequestExecutor,
        ).getContent<MockedContentResult>(filters: getContentFilters, fromJson: MockedContentResult.fromJson);
        verify(await mockedRequestExecutor.executeGetContentRequest<MockedContentResult>(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: getContentFilters,
          fromJson: MockedContentResult.fromJson
        )).called(1);
      });
      test('searchContents method should call RequestExecutor.executeSearchContentsRequest method', () async {
        final searchContentsFilters = SearchContentsFilters(take: 0, skip: 0);
        final requestPath = getOnlinePath(spaceId: config.spaceId, requestType: RequestTypes.search, channel: publishingChannel);
        final mockedRequestExecutor = MockedRequestExecutor();
        when(mockedRequestExecutor.executeSearchContentsRequest<MockedContentResult>(
          path: requestPath,
          apiKey: publicId,
          config: config,
          filters: searchContentsFilters,
          fromJson: MockedContentResult.fromJson)
        ).thenAnswer((_) => mockedPaginatedResult);
        await OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: mockedRequestExecutor)
        .searchContents<MockedContentResult>(filters: searchContentsFilters, fromJson: MockedContentResult.fromJson);
        verify(await mockedRequestExecutor.executeSearchContentsRequest(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: searchContentsFilters,
          fromJson: MockedContentResult.fromJson)
        ).called(1);
      });
    });


    group('PreviewChannel test', () {
      final stageStatus = PublishingStatus.stage;

      test('Initialize successfully', () {
        expect(OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: MockedRequestExecutor(),
        ),
            const TypeMatcher<OnlineChannel>()
        );
      });
      test('Initialize throw an exception if apiKey is null', () {
        expect(() =>
            OnlineChannel(
              config: config,
              apiKey: null,
              publishingChannel: publishingChannel,
              requestExecutor: MockedRequestExecutor(),
            ),
            throwsException
        );
      });
      test('Initialize throw an exception if publishingChannel is null', () {
        expect(() =>
            OnlineChannel(
              config: config,
              apiKey: apiKey,
              publishingChannel: null,
              requestExecutor: MockedRequestExecutor(),
            ),
            throwsException
        );
      });
      test('Initialize throw an exception if requestExecutor is null', () {
        expect(() =>
            OnlineChannel(
              config: config,
              apiKey: apiKey,
              publishingChannel: publishingChannel,
              requestExecutor: null,
            ),
            throwsException
        );
      });
      test('getContent method should call RequestExecutor.executeGetContentRequest method', () async {
        final getContentFilters = GetContentFilters(publicId: publicId);
        final requestPath = getPreviewPath(spaceId: config.spaceId, requestType: RequestTypes.content, channel: publishingChannel, status: stageStatus);
        final mockedRequestExecutor = MockedRequestExecutor();
        when(mockedRequestExecutor.executeGetContentRequest<MockedContentResult>(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: getContentFilters,
          fromJson: MockedContentResult.fromJson)
        ).thenAnswer((_) => mockedGetResult);
        await PreviewChannel(
          status: stageStatus,
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: mockedRequestExecutor,
        ).getContent<MockedContentResult>(filters: getContentFilters, fromJson: MockedContentResult.fromJson);
        verify(await mockedRequestExecutor.executeGetContentRequest<MockedContentResult>(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: getContentFilters,
          fromJson: MockedContentResult.fromJson)
        ).called(1);
      });
      test('searchContents method should call RequestExecutor.executeSearchContentsRequest method', () async {
        final searchContentsFilters = SearchContentsFilters(take: 0, skip: 0);
        final requestPath = getOnlinePath(spaceId: config.spaceId, requestType: RequestTypes.search, channel: publishingChannel);
        final mockedRequestExecutor = MockedRequestExecutor();
        when(mockedRequestExecutor.executeSearchContentsRequest<MockedContentResult>(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: searchContentsFilters,
          fromJson: MockedContentResult.fromJson)
        ).thenAnswer((_) => mockedPaginatedResult);
        await OnlineChannel(
          config: config,
          apiKey: apiKey,
          publishingChannel: publishingChannel,
          requestExecutor: mockedRequestExecutor)
        .searchContents<MockedContentResult>(filters: searchContentsFilters, fromJson: MockedContentResult.fromJson);
        verify(await mockedRequestExecutor.executeSearchContentsRequest(
          path: requestPath,
          apiKey: apiKey,
          config: config,
          filters: searchContentsFilters,
          fromJson: MockedContentResult.fromJson)
        ).called(1);
      });
    });
  });
}
