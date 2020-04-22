import 'package:test/test.dart';
import 'package:contentchef_dart/src/urls.dart';
import 'package:contentchef_dart/src/requests_resources.dart';


void main() {
  group('ContentChef urls tests', () {
    final spaceId = 'test-space-id';
    final channel = 'test-channel';

    group('ContentChef online paths', () {
      test('get online content path', () {
        final requestType = RequestTypes.content;
        final expectedPath = '/space/$spaceId/online/$requestType/$channel';
        expect(getOnlinePath(spaceId: spaceId, requestType: requestType, channel: channel), equals(expectedPath));
      });
      test('search online contents path', () {
        final requestType = RequestTypes.search;
        final expectedPath = '/space/$spaceId/online/$requestType/$channel';
        expect(getOnlinePath(spaceId: spaceId, requestType: requestType, channel: channel), equals(expectedPath));
      });
    });

    group('ContentChef preview paths', () {
      test('get staging preview content path', () {
        final requestType = RequestTypes.content;
        final status = PublishingStatus.stage;
        final expectedPath = '/space/$spaceId/preview/$status/$requestType/$channel';
        expect(getPreviewPath(spaceId: spaceId, requestType: requestType, status: status, channel: channel), equals(expectedPath));
      });

      test('get live preview content path', () {
        final requestType = RequestTypes.content;
        final status = PublishingStatus.live;
        final expectedPath = '/space/$spaceId/preview/$status/$requestType/$channel';
        expect(getPreviewPath(spaceId: spaceId, requestType: requestType, status: status, channel: channel), equals(expectedPath));
      });

      test('get staging preview search contents path', () {
        final requestType = RequestTypes.search;
        final status = PublishingStatus.stage;
        final expectedPath = '/space/$spaceId/preview/$status/$requestType/$channel';
        expect(getPreviewPath(spaceId: spaceId, requestType: requestType, status: status, channel: channel), equals(expectedPath));
      });

      test('get live preview search contents path', () {
        final requestType = RequestTypes.content;
        final status = PublishingStatus.live;
        final expectedPath = '/space/$spaceId/preview/$status/$requestType/$channel';
        expect(getPreviewPath(spaceId: spaceId, requestType: requestType, status: status, channel: channel), equals(expectedPath));
      });
    });

  });
}
